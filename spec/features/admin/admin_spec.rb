require "rails_helper"
include Warden::Test::Helpers
Warden.test_mode!

describe "Admin", type: :feature do

  before do
    @admin = FactoryGirl.create(:admin)
  end

  describe "sign_in" do
    before do
      visit new_admin_session_path
      within("#new_admin") do
        fill_in 'Email', with: @admin.email
        fill_in 'Password', with: @admin.password
      end
      click_button 'Log in'
    end

    it { expect(page).to have_content "Signed in successfully." }
  end

  describe "sign_out" do
    before do
      login_as(@admin, scope: :admin)
      visit admin_root_path
      click_link 'Sign out'
    end

    it { expect(page).to have_content "Signed out successfully." }
  end

  describe "edit profile" do
    before do
      login_as(@admin, scope: :admin)
      visit admin_root_path
      click_link 'Edit profile'
      within("#edit_admin") do
        fill_in 'Email', with: 'example@edited.com'
      end
      click_button 'Update'
    end

    it { expect(page).to have_content 'Your account has been updated successfully.' }
  end
end
