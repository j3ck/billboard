class HomeController < ApplicationController
  def index
    #@adverts = Advert.where(state: :published)
    @adverts = Advert.all
    @search = @adverts.search(params[:q])
    @adverts = @search.result(distinct: true)
  end
end
