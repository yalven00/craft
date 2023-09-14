class StaticPagesController < ApplicationController
  def home
    redirect_to welcome_path if user_signed_in?
  end

  def terms
  end

  def privacy
  end

  def about
  end

  def thank_you
  end

  def welcome
  end

  def landing
    render :landing, layout: false
  end
end
