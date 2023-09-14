class RegistrationsController < Devise::RegistrationsController
  def update
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(resource_params)
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end

  def resource_params
     params.require(:user).permit(:email, :password, :first_name, :last_name, :birth_date, :country, :zip, :gender)
  end

protected

  def after_inactive_sign_up_path_for(resource)
    thank_you_path
  end
end
