class CommentsController < ApplicationController
    before_action :require_user_logged_in, only: [:create]
    before_action :correct_user,   only: [:destroy]
    before_action :favorit_list

  def create 
    
    @comment = current_user.comments.build(comment_params)
    @comment.folder_id = params[:folder_id]
    @comment.photo_id = params[:photo_id]
    if @comment.save
      @folder = Folder.find(params[:folder_id])
      @photo = Photo.find(params[:photo_id])        
      flash[:success] = 'コメントしました'
      redirect_to "/folders/#{@folder.id}/photos/#{@photo.id}"
    else
      @folder = Folder.find(params[:folder_id])
      @photo = Photo.find(params[:photo_id])  
      @comments = @photo.comments.order(id: :desc).page(params[:page]).per(20)
      flash.now[:danger] = 'コメント失敗'
      render 'photos/show'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
          @folder = Folder.find(params[:folder_id])
      @photo = Photo.find(params[:photo_id])  
      @comments = @photo.comments
    flash[:success] = "コメントを削除しました"
    redirect_to "/folders/#{@folder.id}/photos/#{@photo.id}"
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end  
  def set_likes
    @favoriteFolders = current_user.likes.order(id: :desc).page(params[:page]).per(24)
  end
end
