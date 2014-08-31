class HomeController < ApplicationController
  def index
    #@adverts = Advert.where(state: :published)
    @adverts = Advert.all
    @search = @adverts.search(params[:q])
    @adverts = @search.result(distinct: true).paginate(page: params[:page], per_page: 5)
  end
end
