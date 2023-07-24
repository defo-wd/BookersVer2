class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home, :about, :new, :create]

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "User updated successfully."
       redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  private

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end
end
