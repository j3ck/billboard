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

    it "loads all of the adverts into @adverts" do
      advert1 = FactoryGirl.build(:advert, title: "Advert1")
      advert2 = FactoryGirl.build(:advert, title: "Advert2")
      get :index
      expect(assigns(:adverts)).to match_array([advert1, advert2])
    end
  end

  describe "GET #show" do
    before { advert = FactoryGirl.create(:advert) }

    it "successfully with 200 HTTP status" do
      get :show, id: advert.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      get :show
      expect(response).to render_template("show")
    end
  end

  describe "POST #create" do
    it "successfully HTTP status" do
      xhr :post, :create, { advert: { title: "Title", description: "Lorem ipsum dolor sit amet.", price: 100, user_id: user.id } }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
