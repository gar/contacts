require 'rails_helper'

RSpec.describe NamedContact, type: :model do
  it 'validates that case id is not blank' do
    contact = NamedContact.create(case_id: '')

    expect(contact).to_not be_valid
    expect(contact.errors[:case_id]).to include("can't be blank")
  end

  it 'validates that case id is unique' do
    NamedContact.create(case_id: '42')

    contact = NamedContact.create(case_id: '42')

    expect(contact).to_not be_valid
    expect(contact.errors[:case_id]).to include('has already been taken')
  end
end
