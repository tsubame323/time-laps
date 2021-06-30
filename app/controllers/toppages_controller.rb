class ToppagesController < ApplicationController
  before_action :favorit_list
  
  def index
    if logged_in?
      @folder = current_user.folders.build
      @folders = Folder.order(id: :desc).page(params[:page]).per(16)
    
      
    end
    @likefolder2 = Folder.order(addlikes: :desc).page(params[:page]).per(1)
    @likefolder = Folder.includes(:addlikes).sort {|a,b| b.addlikes.size <=> a.addlikes.size}
    @ranPhotos = Photo.order("RAND()").limit(6)
    
    @photos = Photo.order(id: :desc).page(params[:page])
    if params[:title].present?
      @searchFolder = Folder.where('title LIKE ?', "%#{params[:title]}%")
    else
      @searchFolder = Folder.none
    end
  end

end