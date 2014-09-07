require 'rails_helper'

describe AdvertsController, type: :controller do

  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe 'GET #show' do
    before do
      @advert = FactoryGirl.create(:advert)
    end

    it 'successfully with 200 HTTP status' do
      get :show, id: @advert.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get :show, id: @advert.id
      expect(response).to render_template('show')
    end
  end

  describe 'GET #index' do
    it 'render index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
