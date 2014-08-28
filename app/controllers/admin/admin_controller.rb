class Admin::AdminController < ApplicationController
  layout 'admin/admin'

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied"
    redirect_to new_admin_session_url, :alert => exception.message
  end
end
