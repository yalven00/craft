class UserListsController < ApplicationController
  def index
    @user_lists = current_user.user_lists
  end

  def new
    @user_list = current_user.user_lists.build
  end

  def create
    @user_list = current_user.user_lists.build(user_list_params)
    @user_list.save
    redirect_to user_lists_path
  end

  def show
    @user_list = current_user.user_lists.find(params[:id])
  end

  def add
    @user_list = current_user.user_lists.find(params[:id])
    @company_id = params[:company_id]
    @user_list.add_company(@company_id)
    respond_to do |format|
      format.js {render 'add', layout: false }
    end
  end

  def remove
    @user_list = current_user.user_lists.find(params[:id])
    @company_id = params[:company_id]
    @user_list.remove_company(@company_id)
    respond_to do |format|
      format.js {render 'remove', layout: false }
    end
  end

private
  def user_list_params
    params.require(:user_list).permit(:name, user_list_line_items_attributes: [:company_id, :user_list_id])
  end
end
