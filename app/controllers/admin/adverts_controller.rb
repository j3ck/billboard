class Admin::AdvertsController < Admin::AdminController
  load_and_authorize_resource
  before_action :set_advert, only: [:in_reject, :in_publish]
  respond_to :json

  def in_reject
    @advert.reject! if @advert.may_reject?
    redirect_to admin_root_url
  end

  def in_publish
    @advert.publish! if @advert.may_publish?
    render json: { advert_id: @advert.id }
  end

  def index
    @adverts = Advert.where(state: :moderated)
    @search = @adverts.search(params[:q])
    @adverts = @search.result
  end

  def show
    @advert = Advert.find(params[:id])
    advert_html = render_to_string( partial: 'admin/adverts/show', formats: [:html], locals: { advert: @advert } )
    respond_with html: advert_html
  end

  private
    def set_advert
      @advert = Advert.find(params[:id])
    end
end
