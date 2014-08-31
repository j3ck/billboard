class Admin::UsersController < Admin::AdminController
  load_and_authorize_resource
  respond_to :json

  def index
    @users = User.all.paginate(page: params[:page], per_page: 20)
  end

  def user_adverts_with_state
    @adverts = Advert.where(user_id: params[:id], state: params[:state])
    adverts = render_to_string( @adverts, :formats => [:html] )
    respond_with :adverts => adverts
  end
end
