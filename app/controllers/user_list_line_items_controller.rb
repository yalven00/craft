class UserListLineItemsController < ApplicationController
  def destroy
    @item = current_user.user_list_line_items.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.js {render :destroy, layout: false}
    end
  end
end
