class Admin::UsersController < ApplicationController
  respond_to :json

  def index
    @users = User.all
  end

  def user_adverts_with_state
    @adverts = Advert.where(user_id: params[:id], state: params[:state])
    adverts = render_to_string( @adverts, :formats => [:html] )
    respond_with :adverts => adverts
  end
end
