class FavoritesController < ApplicationController
   before_action :require_user_logged_in
   before_action :favorit_list
  def create
    @folder = Folder.find(params[:folder_id])
    folder = Folder.find(params[:folder_id])
    current_user.favorite(folder)
  end

  def destroy
    @folder = Folder.find(params[:folder_id])
    folder = Folder.find(params[:folder_id])
    current_user.unfavorite(folder)
  end
end