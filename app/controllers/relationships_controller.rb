class RelationshipsController < ApplicationController
  
  before_filter :authenticate
  
  def create
    # raise params.inspect
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    # block to handle AJAX request
    respond_to do |format|
      format.html {redirect_to @user} #response for regular html response
      format.js #response for js response - if no argument passed, it will automaticaly execute contents of [action].js.erb - ie create.js.erb
    end  
    
  end
  
  def destroy
    # raise params.inspect
    # relationship = Relationship.find(params[:id]).destroy
    # redirect_to relationship.followed
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html {redirect_to @user} #response for regular html response
      format.js #response for js response - if no argument passed, it will automaticaly execute contents of [action].js.erb - ie destroy.js.erb
    end
  end  
end    
  