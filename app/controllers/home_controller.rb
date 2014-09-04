class HomeController < ApplicationController
  def index
    @adverts = Advert.includes(:category, :type).where(state: :published)
    @search = @adverts.search(params[:q])
    @adverts = @search.result(distinct: true).paginate(page: params[:page], per_page: 5)
  end
end
