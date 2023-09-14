class CategoriesController < ApplicationController
  def search
    render json: Category.search(params[:search])
  end
end
