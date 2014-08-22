require 'rails_helper'

describe AdvertsController, type: :controller do

  before do
    user = FactoryGirl.build(:user)
    sign_in user
  end

  describe "GET #index" do
    it "successfully with 200 HTTP status" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the adverts into @categories" do
      category1 = FactoryGirl.build(:category, title: "Category1")
      category2 = FactoryGirl.build(:category, title: "Category2")
      get :index
      expect(assigns(:categories)).to match_array([category1, category2])
    end
  end
end
