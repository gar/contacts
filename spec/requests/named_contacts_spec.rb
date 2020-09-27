require 'rails_helper'

RSpec.describe "NamedContacts", type: :request do
  describe "GET /named_contacts" do
    it "requires a user to be logged in" do
      get '/named_contacts?case_id=foobar'
      expect(response).to have_http_status(403)
    end

    it "requires a case id to be supplied" do
      expect { get '/named_contacts' }.to raise_error(ActionController::RoutingError)
    end
  end
end
