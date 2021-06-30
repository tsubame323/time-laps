class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index]
  before_action :favorit_list
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @folders = @user.folders.order(id: :desc).page(params[:page]).per(16)
    @favoCount = @user.likes.count
    @userFolders = @user.folders
    @favCount = 0
    @userFolders.each do |folder|
  @favCount += folder.favorites.count
  
end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def likes
    @user = User.find(params[:id])
    @folders = @user.likes.page(params[:page])
    counts(@user)
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
