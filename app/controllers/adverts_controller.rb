class AdvertsController < ApplicationController
  load_and_authorize_resource
  before_action :state, only: [:in_moderate, :in_archive, :in_newest, :update, :create]
  after_action :add_log, only: [:in_moderate, :in_archive, :in_newest, :update, :create]

  def change_state
    state_name = params[:state_to_change]
    if @advert.send("may_#{state_name}?")
      @advert.send("#{state_name}!")
      redirect_to adverts_path(state: state_name)
    else
      redirect_to root_url, alert: exception.message
    end
  end

  #def in_moderate
  #  @advert.moderate! if @advert.may_moderate?
  #  redirect_to adverts_path(state: 'moderated')
  #end

  #def in_archive
  #  @advert.archive! if @advert.may_archive?
  #  redirect_to adverts_path(state: 'archived')
  #end

  #def in_newest
  #  @advert.newest! if @advert.may_newest?
  #  redirect_to adverts_path(state: 'template')
  #end

  def index
    params[:state] = 'template' unless params[:state].present?
    @adverts = current_user.adverts.stated(params[:state]).paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
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

  def state
    @state = @advert.state
  end

  def add_log
    @log = @advert.logs.build(editor_id: current_user.id, editor_role: 'User', action: action_name, last_state: @state, current_state: @advert.state)
    @log.save(validate: false)
  end


  def advert_params
    params.require(:advert).permit(:title, :description, :price, :category_id, :type_id, image_ids: [])
  end
end
