class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
      flash[:success] = "Welcome to Sample Page, " + @user.name + "!!"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Render success
      flash[:success] = "Welcome to Sample Page, " + @user.name + "!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :uName, :email, :password, :password_confirmation)
    end
end
