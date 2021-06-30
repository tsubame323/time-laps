class ApplicationController < ActionController::Base
  before_action :favorit_list
  
    include SessionsHelper
      private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(folder)
    
  end
  
  def favorit_list
    if logged_in?
       @favoriteFolders = current_user.likes.order(id: :desc).page(params[:page])
       @folderBuild = current_user.folders.build
    end
  end
  

private
  

  
end

