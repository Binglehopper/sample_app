class MicropostsController < ApplicationController
  
  before_filter :authenticate #by default it will run before_filter for all actions in the controller
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      redirect_to root_path, :flash => {:success => "Micropost created!"}
    else
      render 'pages/home'
    end
  end
  
  def destroy
    
  end
  
end