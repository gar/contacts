class ApplicationController < ActionController::Base
  before_action :decode_auth_token

  private

  def decode_auth_token
    unless skip_auth?
      token = request.headers.fetch('Authorization', '').gsub(/^Bearer /, '')
      pub_key = OpenSSL::PKey::RSA.new(Rails.configuration.jwt.public_key)
      begin
        @decoded_jwt_claims, _ = JWT.decode(token, pub_key, true, { iss: 'parc-cli', verify_iss: true, verify_iat: true, algorithm: 'RS256' })
      rescue JWT::DecodeError => e
        logger.info "Unable to decode JWT token: #{e.message}"
        head :forbidden
      end
    end
  end

  def skip_auth?
    Rails.configuration.skip_auth && (Rails.env.development? || Rails.env.test?)
  end
end
