require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Admin::Adverts", type: :feature do

  before do
    @type = FactoryGirl.create(:type)
    @category = FactoryGirl.create(:category)
    @advert = FactoryGirl.create(:advert, state: "moderated", type_id: @type.id, category_id: @category.id)
    @admin = FactoryGirl.create(:admin)
    login_as(@admin, scope: :admin)
    visit admin_root_path
  end

  it { expect(page).to have_content 'Adverts await moderation' }
  it { expect(page).to have_link 'Title' }
  it { expect(page).to have_link 'Price' }
  it { expect(page).to have_link 'Category' }
  it { expect(page).to have_link 'Type' }
  it { expect(page).to have_link 'Posted by' }
  it { expect(page).to have_content 'Description' }
  it { expect(page).to have_content @advert.title }
  it { expect(page).to have_content @advert.price }
  it { expect(page).to have_content @advert.category.name }
  it { expect(page).to have_content @advert.type.name }
  it { expect(page).to have_content @advert.updated_at }
  it { expect(page).to have_link 'Publish' }
  it { expect(page).to have_link 'Reject' }

=begin
  describe "show advert", js: true do
    before do
      click_link @advert.title
    end
    it { expect(page).to have_content 'Show advert full info' }
    it { expect(page).to have_content @advert.title }
    it { expect(page).to have_content 'Price:' }
    it { expect(page).to have_content 'Type:' }
    it { expect(page).to have_link 'Publish' }
    it { expect(page).to have_link 'Reject' }
  end
=end
  describe "Publish" do
    before { click_link 'Publish' }

    it { expect(page).not_to have_content @advert.title }
  end
=begin
  describe "Reject", js: true do
    before { click_link 'Reject' }

    describe "reject form", js: true do
      it { expect(page).to have_content 'Add comment to reject:' }
      it { expect(page).to have_content '×' }
      it { expect(page).to have_content 'Comment' }
      it { expect(page).to have_field 'Comment' }
      it { expect(page).to have_button 'Reject' }
    end

    it "reject success", :driver => :webkit do
      before do
        within("#new_log") do
          fill_in 'Comment', with: 'Test reason.'
        end
        click_button 'Reject'
      end
      expect(page).not_to have_content @advert.title
    end

    describe "reject error", js: true do
      before do
        click_button 'Reject'
      end
      it { expect(page).to have_content 'Please review the problems below:' }
      it { expect(page).to have_content "can't be blank" }
    end
  end
=end
end
