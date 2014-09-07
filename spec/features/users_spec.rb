require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'User', type: :feature do

  before do
    @user = FactoryGirl.create(:user)
  end

  describe 'sign_up' do
    before do
      visit new_user_registration_path
      within('#new_user') do
        fill_in 'Email', with: 'example@example.com'
        fill_in 'Password', with: 123_123_123
        fill_in 'Password confirmation', with: 123_123_123
      end
      click_button 'Sign up'
    end

    it { expect(page).to have_content 'Welcome! You have signed up successfully.' }
  end

  describe 'sign_in' do
    before do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'example@email.com'
        fill_in 'Password', with: 123_123_123
      end
      click_button 'Sign in'
    end

    it { expect(page).to have_content 'Signed in successfully.' }
  end

  describe 'sign_out' do
    before do
      login_as(@user)
      visit root_path
      click_link 'Sign out'
    end

    it { expect(page).to have_content 'Signed out successfully.' }
  end

  describe 'edit profile' do
    before do
      login_as(@user)
      visit root_path
      click_link 'Edit profile'
      within('#edit_user') do
        fill_in 'Email', with: 'example@edited.com'
      end
      click_button 'Update'
    end

    it { expect(page).to have_content 'Your account has been updated successfully.' }
  end
end
