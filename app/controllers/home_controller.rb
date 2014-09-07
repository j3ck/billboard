class HomeController < ApplicationController
  def index
    @adverts = Advert.stated('published')
    @search = @adverts.search(params[:q])
    @adverts = @search.result(distinct: true).paginate(page: params[:page], per_page: 5)
    @categories = Category.recent
    @types = Type.all
  end
end
