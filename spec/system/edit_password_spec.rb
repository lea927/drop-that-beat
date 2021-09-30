require 'rails_helper'

RSpec.describe 'Edit Password', type: :system do
  include_context 'when user is logged in'

  let(:fillout_form) do
    fill_in 'user_password', with: 'password123'
    fill_in 'user_password_confirmation', with: 'password123'
  end

  before do
    visit home_path
    find('#navbarDropdown').click
    click_on 'Update Password'
    fillout_form
  end

  describe 'Updating password' do
    it 'can access edit user page' do
      expect(page).to have_current_path(edit_user_registration_path)
    end

    context 'with valid current password' do
      it 'displays success message' do
        fill_in 'user_current_password', with: 'password'
        click_on 'Update'
        expect(page).to have_content('Your account has been updated successfully.')
      end
    end

    context 'with invalid current password' do
      it 'displays error message' do
        fill_in 'user_current_password', with: 'password098'
        click_on 'Update'
        expect(page).to have_content('Current password is invalid')
      end
    end
  end
end
