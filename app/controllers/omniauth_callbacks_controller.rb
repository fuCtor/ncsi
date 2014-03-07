class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def vkontakte
    auth
  end

  def github
    auth
  end

  def logout
    sign_out_and_redirect @user
  end

  def auth
    omniauth = request.env["omniauth.auth"]
    @user = User.find_for_oauth(omniauth, current_user)
    if @user && @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => omniauth.provider) if is_navigational_format?
    else
      redirect_to admin_denied_path
    end
  end
end