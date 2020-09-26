require 'ostruct'

class ApplicationController < ActionController::Base
  before_action :decode_auth_token

  private

  def decode_auth_token
    unless Rails.configuration.skip_auth
      token = request.headers.fetch('Authorization', '').gsub(/^Bearer /, '')
      pub_key = OpenSSL::PKey::RSA.new(Rails.configuration.jwt.public_key)
      begin
        decoded_jwt_claims, _ = JWT.decode(token, pub_key, true, { iss: 'parc-cli', verify_iss: true, verify_iat: true, algorithm: 'RS256' })
        @current_user_id = decoded_jwt_claims.fetch('sub')
      rescue JWT::DecodeError => e
        logger.info "Unable to decode JWT token: #{e.message}"
        head :forbidden
      end
    end
  end

  def current_user
    if Rails.configuration.skip_auth
      OpenStruct.new(id: 'DEVELOPMENT_USER')
    else
      OpenStruct.new(id: @current_user_id)
    end
  end
end
