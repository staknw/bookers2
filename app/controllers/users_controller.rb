class UsersController < ApplicationController
  
  # 他人のユーザ情報編集画面に遷移できない
  before_action :correct_user, only: [:edit, :update]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] ="Signed in successfully."
      redirect_to user_path(@user)
    else
      @users = User.new
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  # ↓これ書かないと新規投稿できない
    @book = Book.new
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:update] ="You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email, :reset_password_token)
  end

# 他人のユーザ情報編集画面に遷移できない
# 現在ログインしているユーザーとuser infoに表示されているのが一緒の時editページが開ける
  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end


end
