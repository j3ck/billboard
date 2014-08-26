class Admin::AdvertsController < ApplicationController
  load_and_authorize_resource
  before_action :set_advert, only: [:in_reject, :in_publish]

  def in_reject
    @advert.reject! if @advert.may_reject?
    redirect_to admin_adverts_path
  end

  def in_publish
    @advert.publish! if @advert.may_publish?
    redirect_to admin_adverts_path
  end

  def index
    @adverts = Advert.where(state: :moderated)
  end


  private
    def set_advert
      @advert = Advert.find(params[:id])
    end
end
