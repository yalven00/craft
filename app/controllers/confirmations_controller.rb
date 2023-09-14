class ConfirmationsController < Devise::ConfirmationsController

  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    if resource.nil? or resource.confirmed?
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])

      if resource.errors.empty?
        set_flash_message(:notice, :confirmed) if is_navigational_format?
        sign_in(resource)
        # respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
        session[:get_started] = true
        respond_with_navigational(resource) {redirect_to edit_user_registration_path}
      else
        respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render :new }
      end
    end
  end

  def confirm
    self.resource = resource_class.find_by_confirmation_token(params[resource_name][:confirmation_token]) if params[resource_name][:confirmation_token].present?
    if resource.update_attributes(params[resource_name].except(:confirmation_token)) && resource.password_match?
      self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])
      set_flash_message :notice, :confirmed
      session[:user_id] = resource.id
      sign_in_and_redirect(resource_name, resource)
    else
      render :action => "show"
    end
  end
end
