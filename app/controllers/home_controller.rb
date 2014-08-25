class HomeController < ApplicationController
  def index
    @adverts = Advert.where(state: :published)
  end
end
