class UsersController < ApplicationController

  #For the profile page
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  #For the sign up page  
  def new
    @user = User.new #create a raw user object
    @title = "Sign up"
  end

  #This is the action that happens when you POST to /users.  Comes from the user:resources in the model
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user, :flash => {:success => "Welcome to the Sample App" }
    else
      @title = "Sign up"
      render 'new'
    end
  end

end
