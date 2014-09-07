require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'Adverts', type: :feature do

  describe 'adverts path guest' do

    before :each do
      visit root_path
    end

    it { expect(page).to have_content 'Published adverts' }
    it { expect(page).to have_button 'Search' }
    it { expect(page).to have_content 'Search by title / description' }
    it { expect(page).to have_content 'Select category for search' }
    it { expect(page).to have_content 'Select type for search' }
    it { expect(page).to have_link 'Billboard' }
    it { expect(page).to have_link 'Sign in' }
    it { expect(page).to have_link 'Sign up' }
  end

  describe 'sign in user' do

    before :each do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)
      @category = FactoryGirl.create(:category)
      @type = FactoryGirl.create(:type)
      @advert = user.adverts.build(title: 'Advert', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda, animi.', price: 100, category_id: @category.id, type_id: @type.id)
      @advert.save
      visit adverts_path
    end

    it { expect(page).to have_link 'Adverts' }
    it { expect(page).to have_link 'Home' }
    it { expect(page).to have_link 'Edit profile' }
    it { expect(page).to have_link 'Sign out' }
    it { expect(page).to have_content 'Listing adverts' }
    it { expect(page).to have_link 'New Advert' }

    it { expect(page).to have_link 'template' }
    it { expect(page).to have_link 'published' }
    it { expect(page).to have_link 'moderated' }
    it { expect(page).to have_link 'rejected' }
    it { expect(page).to have_link 'archived' }
    it { expect(page).to have_link 'Edit' }
    it { expect(page).to have_content 'Lorem ipsum dolor' }

    describe 'edit advert' do
      before do
        click_link 'Edit'
      end

      it { expect(page).to have_button 'Update Advert' }

      it 'successfully edited' do
        within("#edit_advert_#{@advert.id}") do
          fill_in 'Title', with: 'Test advert test'
          fill_in 'Description', with: 'Lorem ipsum dolor sit amet. Test'
          fill_in 'Price', with: 1204
          select(@category.name, from: 'advert_category_id')
          select(@type.name, from: 'advert_type_id')
        end
        click_button 'Update Advert'
      end
    end

    describe 'create advert' do
      before do
        click_link 'New Advert'
      end

      it { expect(page).to have_content 'New advert' }
      it { expect(page).to have_content 'Add image file' }
      it { expect(page).to have_content 'Title' }
      it { expect(page).to have_field 'Title' }
      it { expect(page).to have_content 'Description' }
      it { expect(page).to have_field 'Description' }
      it { expect(page).to have_content 'Price' }
      it { expect(page).to have_field 'Price' }
      it { expect(page).to have_content 'Category' }
      it { expect(page).to have_select 'advert_category_id' }
      it { expect(page).to have_content 'Type' }
      it { expect(page).to have_select 'advert_type_id' }
      it { expect(page).to have_button 'Create Advert' }
      it { expect(page).to have_link 'Back' }

      describe 'have created advert' do
        before do
          within('#new_advert') do
            fill_in 'Title', with: 'Test advert'
            fill_in 'Description', with: 'Lorem ipsum dolor sit amet.'
            fill_in 'Price', with: 120
            select(@category.name, from: 'advert_category_id')
            select(@type.name, from: 'advert_type_id')
          end
          click_button 'Create Advert'
        end

        it { expect(page).to have_content 'Advert was successfully created.' }
        it { expect(page).to have_content 'Test advert' }
        it { expect(page).to have_content 'Lorem ipsum dolor sit amet.' }
        it { expect(page).to have_content '120' }
        it { expect(page).to have_content @category.name }
        it { expect(page).to have_content @type.name }
        it { expect(page).to have_link 'Back' }
        it { expect(page).to have_link 'Edit' }
        it { expect(page).to have_link 'Send for moderation' }
        it { expect(page).not_to have_link 'Send in newest' }

        describe 'have advert logs' do
          it { expect(page).to have_content 'Logs' }
          it { expect(page).to have_content 'Action:' }
          it { expect(page).to have_content 'create' }
          it { expect(page).to have_content 'template' }
          it { expect(page).to have_content 'User' }
        end

        describe 'advert with error' do
          before do
            visit adverts_path
            click_link 'New Advert'
            click_button 'Create Advert'
          end

          it { expect(page).to have_content 'Please review the problems below:' }
          it { expect(page).to have_content "can't be blank" }
          it { expect(page).to have_content 'is not a number' }
        end
      end
    end

    describe 'changing states' do
      before do
        visit advert_path(@advert)
      end

      it 'in moderate' do
        click_link 'Send for moderation'
        expect(page).to have_content(@advert.title)
        expect(page).to have_content('Send in newest')
      end

      it 'in newest' do
        click_link 'Send for moderation'
        click_link 'Send in newest'
        expect(page).to have_content(@advert.title)
        expect(page).to have_content('Send for moderation')
      end

      it 'in archive' do
        @advert.state = 'published'
        @advert.save
        visit advert_path(@advert)
        click_link 'Send in archive'
        expect(page).to have_content(@advert.title)
        expect(page).to have_content('Send in newest')
      end
    end
  end
end
