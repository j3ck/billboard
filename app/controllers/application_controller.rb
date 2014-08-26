class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied"
    redirect_to root_url, :alert => exception.message
  end

  private
    def current_ability
      controller_name_segments = params[:controller].split('/')
      controller_name_segments.pop
      controller_namespace = controller_name_segments.join('/').camelize
      Ability.new(current_user, current_admin, controller_namespace)
    end
end
