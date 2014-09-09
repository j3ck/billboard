class Admin::AdvertsController < Admin::AdminController
  load_and_authorize_resource
  respond_to :json

  def in_publish
    @advert.publish! if @advert.may_publish?
    render json: { advert_id: @advert.id }
  end

  def index
    @adverts = Advert.stated('moderated')
    @search = @adverts.search(params[:q])
    @adverts = @search.result.paginate(page: params[:page], per_page: 20)
  end

  def show
    advert_html = render_to_string(partial: 'admin/adverts/show', formats: [:html], locals: { advert: @advert })
    respond_with html: advert_html
  end
end
