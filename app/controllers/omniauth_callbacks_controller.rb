class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :authenticate_user!, except: :failure

  def linkedin
    unless current_user.present?
      user = User.create_from_linkedin(request.env["omniauth.auth"])
      sign_in user
      session[:get_started] = true
    end
    connect_to_linkedin
    redirect_to user.present? ? edit_registration_path(user) : root_path
  end

  def failure
    render 'static_pages/omniauth_failure'
  end

private

  def connect_to_linkedin
    if current_user.connect_to_linkedin(request.env["omniauth.auth"])
      set_flash_message(:notice, :success, kind: "LinkedIn")
    else
      set_flash_message(:notice, :failure, kind: "LinkedIn")
    end
  end
end
