require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Adverts", type: :feature do

  describe "adverts path guest" do

    before :each do
      visit root_path
    end

    it { expect(page).to have_content "Published adverts" }
    it { expect(page).to have_button "Search" }
    it { expect(page).to have_content "Search by title / description" }
    it { expect(page).to have_content "Select category for search" }
    it { expect(page).to have_content "Select type for search" }
    it { expect(page).to have_link "Billboard" }
    it { expect(page).to have_link "Sign in" }
    it { expect(page).to have_link "Sign up" }
  end

  describe "sign in user" do

    before :each do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)
      category = FactoryGirl.create(:category)
      type = FactoryGirl.create(:type)
      advert = user.adverts.build(title: "Advert", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda, animi.", price: 100, category_id: category.id, type_id: type.id)
      advert.save
      visit adverts_path
    end

    it { expect(page).to have_link "Adverts" }
    it { expect(page).to have_link "Home" }
    it { expect(page).to have_link "Edit profile" }
    it { expect(page).to have_link "Sign out" }
    it { expect(page).to have_content "Listing adverts" }
    it { expect(page).to have_link "New Advert"}

    it { expect(page).to have_link "template" }
    it { expect(page).to have_link "published" }
    it { expect(page).to have_link "moderated" }
    it { expect(page).to have_link "rejected" }
    it { expect(page).to have_link "archived" }
    it { expect(page).to have_link "Edit" }
    it { expect(page).to have_content "Lorem ipsum dolor" }
  end
end
