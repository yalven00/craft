class FeedbacksController < ApplicationController
  def create
    FeedbackMailer.feedback(params[:email], params[:name], params[:message]).deliver
    redirect_to :back, flash: {notice: 'Thank you for your feedback.'}
  end
end
