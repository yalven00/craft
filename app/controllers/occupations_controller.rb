# class OccupationsController < ApplicationController
#   def index
#   end

#   def search
#     @result = Occupation.search(params[:search])
#     respond_to do |format| 
#      format.js { render :search, layout: false }
#     end 
#   end

#   def areas
#     if params[:term].present?
#       render json: Occupation.find_area(params[:term])
#     end
#   end

#   def titles
#     if params[:term].present?
#       render json: Occupation.find_occupation(params[:term])
#     end
#   end
# end
