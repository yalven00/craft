# class MarketSalariesController < ApplicationController

#   def index
#   end

#   def search
#     @result = MarketSalary.search(params[:search]).order('submitted_date DESC').page(params[:page])
#     respond_to do |format|
#       format.js { render :search, layout: false }
#     end
#   end

#   def titles
#     render json: MarketSalary.autocomplete(params[:term], 'job_title')
#   end

#   def companies
#     render json: MarketSalary.autocomplete(params[:term], 'employer_name')
#   end
# end
