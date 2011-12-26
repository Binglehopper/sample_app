class UsersController < ApplicationController

  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end

  #For the profile page - SHOW action
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  #For the sign up page - NEW action
  def new
    @user = User.new #create a raw user object
    @title = "Sign up"
  end

  #This is the action that happens when you POST to /users - CREATE action 
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

  #For the edit page - EDIT action
  def edit 
    @user = User.find(params[:id])
    @title = "Edit user"
  end
  
  #For the updating of profiles - UPDATE action
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # it worked
      redirect_to @user, :flash => {:success => "Profile updated."}
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  private
    def authenticate
      deny_access unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end 
  
end
