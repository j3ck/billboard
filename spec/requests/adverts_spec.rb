require 'rails_helper'

describe 'Adverts' do

  before do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
    @advert = FactoryGirl.create(:advert)
  end

  describe 'GET /adverts' do
    it 'adverts path with successfully status ' do
      get adverts_path
      expect(response.status).to be(200)
    end
  end
end
