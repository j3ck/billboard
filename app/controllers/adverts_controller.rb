class AdvertsController < ApplicationController
  load_and_authorize_resource
  before_action :set_advert, only: [:in_moderate, :in_archive, :in_newest, :show, :edit, :update]

  def in_moderate
    @advert.moderate! if @advert.may_moderate?
    redirect_to adverts_path(state: 'moderated')
  end

  def in_archive
    @advert.archive! if @advert.may_in_archive?
    redirect_to adverts_path(state: 'archived')
  end

  def in_newest
    @advert.newest! if @advert.may_newest?
    redirect_to adverts_path(state: 'template')
  end

  def index
    unless params[:state].present?
      params[:state] = 'template'
    end
    @adverts = current_user.adverts.where(state: params[:state]).paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @advert = Advert.new
  end

  def edit
  end

  def create
    @advert = current_user.adverts.build(advert_params)
    if @advert.save
      redirect_to @advert, notice: 'Advert was successfully created.'
    else
      render :new
    end
  end

  def update
    if @advert.update(advert_params)
      @advert.newest!
      redirect_to @advert, notice: 'Advert was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_advert
      @advert = Advert.find(params[:id])
    end

    def advert_params
      params.require(:advert).permit(:title, :description, :price, :category_id, :type_id, {image_ids: []})
    end
end
