class Api::UsersController < ApplicationController
  # Only authorized users may access this resource.
  # before_filter :authenticate_user!
  
  # GET /users.json
  def index
    @users = User.all
    
    respond_to do |format|
      format.json { render json: @pages }
    end
  end
  
  # GET /users/deleted.json
  def deleted
    @users = User.where(deleted_at: { "$exists" => true })
    
    respond_to do |format|
      format.json { render json: @users }
    end
  end  
end