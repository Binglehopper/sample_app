class UsersController < ApplicationController

  #For the profile page
  def show
    @user = User.find(params[:id])
  end
  
  #For the sign up page  
  def new
    @title = "Sign up"
  end

end
