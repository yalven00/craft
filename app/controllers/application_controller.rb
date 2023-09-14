class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_filter :authenticate
  before_filter :turn_off_ssl

  def authenticate
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == "bo2852671k7Xx6V"
      end 
    end
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def turn_off_ssl
    headers['Strict-Transport-Security'] = 'max-age=0'
  end
end
