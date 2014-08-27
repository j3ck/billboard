class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  providers = [:facebook, :vkontakte, :twitter, :google_oauth2]
  providers.each do |provider|
    define_method(provider.to_sym) do
      @user = User.find_for_social_oauth(request.env['omniauth.auth'])
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
      else
        session["devise.#{provider}_data"] = request.env['omniauth.auth']
        redirect_to new_user_session_path
      end
    end
  end
end
