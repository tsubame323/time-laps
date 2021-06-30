class FoldersController < ApplicationController
  
    before_action :require_user_logged_in, only: [:create]

  before_action :correct_user, only: [:destroy]
  before_action :favorit_list
  
  def index
    
    @likefolder = Folder.includes(:addlikes).sort {|a,b| b.addlikes.size <=> a.addlikes.size}
    @decreasingfolder = Folder.includes(:photos).sort {|a,b| b.photos.size <=> a.photos.size}
    @folders = Folder.order(id: :desc).page(params[:page]).per(16)
    
    @upPhoto = Photo.order(updated_at: :desc).page(params[:page]).per(16)
    
    counts(@folder)
  end
  def fav
    @likefolder2 = Folder.includes(:addlikes).sort {|a,b| b.addlikes.size <=> a.addlikes.size}
    @likefolder = Favorite.order(folder_id: :asc).page(params[:page]).per(16)
  end
  def lotsPost
    @decreasingfolder = Folder.includes(:photos).sort {|a,b| b.photos.size <=> a.photos.size}
  end
  def search
    if params[:title].present?
      @searchFolder = Folder.where('title LIKE ?', "%#{params[:title]}%")
    else
      @searchFolder = Folder.none
    end
  end
  
  def create
    @folderBuild = current_user.folders.build(folder_params)
    if @folderBuild.save
      flash[:success] = "作成完了"
      redirect_to @folderBuild
    else
      @folders = current_user.folders.order(id: :desc).page(params[:page])
      @likefolder = Folder.order(addlikes: :desc).page(params[:page]).per(3)
      @ranPhotos = Photo.order("RAND()").limit(6)
      flash.now[:danger] = '作成失敗'
      render 'toppages/index'
    end
  end
  
  def destroy
    @folder.destroy
    flash[:success] = "削除成功"
    redirect_to @folder.user
  end
  
  def show
    @folder = Folder.find(params[:id])
    @photo = Photo.new
    @photos = @folder.photos.order(date: :asc).page(params[:page]).per(15)
    
    @countComment = counts(@folder.comments)
    
    
  end
  
  def addlikes
    @folder = Folder.find(params[:id])
    @addlikes = @folder.addlikes.page(params[:page])
    counts(@addlikes)
  end
  
  private

  
  def folder_params
    params.require(:folder).permit(:title, :content)
  end
  
  def correct_user
    @folder = current_user.folders.find_by(id: params[:id])
    unless @folder
      redirect_to root_url if @folder.nil
    end
  end


end


