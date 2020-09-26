require_relative '../../lib/case_constraint'

RSpec.describe CaseConstraint do
  it 'matches when a request with a case_id query param' do
    good_request = double('request with case_id', query_parameters: { case_id: '123' })

    expect(CaseConstraint.new.matches?(good_request)).to be true
  end

  it 'does not match a request missing a case_id query param' do
    bad_request = double('request without case_id', query_parameters: {})

    expect(CaseConstraint.new.matches?(bad_request)).to be false
  end
end
