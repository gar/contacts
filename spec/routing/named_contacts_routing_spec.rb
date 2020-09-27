require 'rails_helper'

RSpec.describe "routing rules for named contacts", type: :routing do
  it "routes the root URL to the show action" do
    expect(get('/?case_id=foobar')).to route_to('named_contacts#show', case_id: 'foobar')
  end
end
