require 'rails_helper'

RSpec.feature "Named contacts management", type: :feature do
  context 'When user is logged in and case id supplied' do
    before do
      jwt_test_token = "eyJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJwYXJjLWNsaSIsInN1YiI6InRlc3RfdG9rZW4iLCJpYXQiOjE2MDA5NTc1ODd9.pmKAP2V1MaD345E0-a-yJDPgqz0v_FHy21xWqpl51we9pWBckPrO2UXqqVvKSG1CwrqcE77R2afZqS-MjA5V8_86P6rga-5WbCSHa67-gtumMxM3IdMDyr4N9pBJcAXtJOXSc5syeN-9bc4IaCX4k3NLlpP2Z6hfvjqV-jnI_TmI0A1eGVLimHHQSV3A_eisiyHgbyrdoMyZG2cM3X0uGN_-3w_XAHRDlkZvOno-twskMv7hNreMVdDm5l6U6lhpvsBtPx1c0Fkp4oZrz0Q_1MA1fxKqzrDeljA6bZhhlAvNhr_ChwGCTf6Rs351xdu8VGU9dRD3Olm3b62vCUUN_A"
      page.driver.header('Authorization', "Bearer #{jwt_test_token}")
    end

    scenario 'they can create a new contact' do
      visit '/named_contacts/new?case_id=foobar'

      fill_in 'named_contact_first_name', with: 'Bobby'
      fill_in 'named_contact_last_name', with: 'Tables'
      click_button('Create')

      expect(page).to have_text('Named contact was created successfully')
    end

    scenario 'they can view an existing contact' do
      NamedContact.create(case_id: 'foobar', first_name: 'Bobby', last_name: 'Tables')

      visit '/named_contacts?case_id=foobar'

      expect(page).to have_selector("input[value='Bobby']")
      expect(page).to have_selector("input[value='Tables']")
    end

    scenario 'they can update an existing contact' do
      NamedContact.create(case_id: 'foobar', first_name: 'Bobby', last_name: 'Tables')

      visit '/named_contacts/edit?case_id=foobar'

      fill_in 'named_contact_mobile_number', with: '424242'
      click_button('Update')

      expect(page).to have_text('Named contact was updated successfully')
      expect(page).to have_selector("input[value='424242']")
    end

    scenario 'they can delete an existing contact' do
      NamedContact.create(case_id: 'foobar', first_name: 'Bobby', last_name: 'Tables')

      visit '/named_contacts?case_id=foobar'

      click_button('Delete')

      expect(page).to have_text('Named contact was deleted successfully')
    end
  end
end
