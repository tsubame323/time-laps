class PhotosController < ApplicationController
  before_action :require_user_logged_in, only: [:create]
  before_action :correct_user, only: :destriy
  before_action :favorit_list
  
  def show
    @folder = Folder.find(params[:folder_id])
    @photo = Photo.find(params[:id])
    @comment = Comment.new
    @comments = @photo.comments.order(id: :desc).page(params[:page]).per(20)
   
  end


  def create 
    @photo = current_user.photos.build(photo_params)
    @photo.folder_id = params[:folder_id]
    if @photo.save
      flash[:success] = '投稿成功'
      redirect_to @photo.folder
    else
      @folder = Folder.find(params[:folder_id])  
      @photos = @folder.photos
      flash.now[:danger] = '投稿失敗'
      render "folders/show"
      
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:success] = "削除成功"
    redirect_to @photo.folder
  end
  
  private
  
  def photo_params
    params.require(:photo).permit(:image, :date)
  end

  
  def correct_user
    @photo = current_user.photos.find_by(id: params[:id])
    redirect_to root_url if @photo.nil?
  end
end



