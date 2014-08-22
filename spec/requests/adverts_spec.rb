require 'rails_helper'

describe "Adverts", type: :request do

  before do
    user = FactoryGirl.build(:user)
    sign_in user
    advert = FactoryGirl.build(:advert)
  end

  describe "GET /adverts" do
    it "adverts path with successfully status " do
      get adverts_path
      expect(response.status).to be(200)
    end
  end

  describe "GET /adverts/:id" do
    it "show adverts path" do
      get advert_path(advert)
      expect(response.status).to be(200)
    end
  end
end
