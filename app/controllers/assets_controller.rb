class AssetsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @asset = current_user.assets.build(for_model: params[:for_model], mid: params[:mid], asset_type: params[:asset_type])
    respond_to do |format|
      format.js { render 'new.js.erb', layout: false }
    end
  end

  def create
    @asset = current_user.assets.build(asset_params)
    @asset.save
    respond_to do |format|
      format.js { render :create, layout: false }
    end
  end

  def update
    @asset = current_user.assets.find(params[:id])
    @asset.update_attributes(asset_params)
    respond_to do |format|
      format.js { render :update, layout: false }
    end
  end

  def destroy
    @asset = current_user.assets.find(params[:id])
    to_render = @asset.for_model
    @id = @asset.id
    @asset.destroy
    respond_to do |format|
      format.js { render to_render, layout: false }
    end
  end

private
  def asset_params
    params.require(:asset).permit(:description, :file, :asset_type, :for_model, :mid)
  end
end
