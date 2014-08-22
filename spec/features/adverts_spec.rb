require 'rails_helper'

describe "Adverts", type: :feature do

  describe "adverts path guest" do

    before :each do
      visit adverts_path
    end

    it { expect(page).to have_content "Published adverts:" }
    it { expect(page).to have_content "Billboard" }
    it { expect(page).to have_content "Filters" }
  end

  describe "description" do

    before :each do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)
      advert = user.adverts.build(title: "Advert", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda, animi.", price: 100)
      visit adverts_path
    end

    it { expect(page).to have_content "Advert" }
    it { expect(page).to have_content "Lorem ipsum dolor" }
    it { expect(page).to have_content "Edit" }
    it { expect(page).to have_content "New Advert" }
    it { expect(page).to have_content "Logout" }
    it { expect(page).to have_content "Dashboard" }
    it { expect(page).to have_content "Edit account" }
  end
end
