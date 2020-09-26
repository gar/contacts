require 'rails_helper'

RSpec.describe "routes for NamedContacts", type: :routing do
  xit "routes the root URL to the show action" do
    expect(get('/?case_id=FOO')).to route_to('named_contacts#show')
  end

  xit "does not route the root URL when no case_id supplied" do
    expect { get('/') }.to raise_error(ActionController::RoutingError)
  end
end
