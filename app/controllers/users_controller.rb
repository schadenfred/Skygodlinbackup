class UsersController < ApplicationController
  
  def index
    @users = current_account.nil? ? User.all : current_account.users
  end

  def show
    @user = User.find(params[:id])
    if !current_account.nil?
      check_my_account(@user.account.name)
    end
  end
  
  def valid
    token_user = User.valid?(params)
    if token_user
      sign_in(:user, token_user)
      flash[:notice] = "You have been logged in"
    else
      flash[:alert] = "Login could not be validated"
    end
    redirect_to :root
  end
end
