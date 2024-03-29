class UsersController < ApplicationController

  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end

  #For the profile page - SHOW action
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
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
    @title = "Edit user"
  end
  
  #For the updating of profiles - UPDATE action
  def update
    if @user.update_attributes(params[:user])
      # it worked
      redirect_to @user, :flash => {:success => "Profile updated."}
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  #For killing users - DESTROY action
  def destroy
    @user.destroy
    redirect_to users_path, :flash => { :success => "User destroyed." }
  end
  
  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end 
    
    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? || current_user?(@user)
    end
  
end
