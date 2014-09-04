class Admin::RegistrationsController < Devise::RegistrationsController
  layout 'admin/admin'

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @admin = Admin.find(current_admin.id)
    if @admin.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      sign_in @admin, :bypass => true
      redirect_to after_update_path_for(@admin)
    else
      render "edit"
    end
  end
end
