class Api::UsersController < ApplicationController
  # Only authorized users may access this resource.
  # before_filter :authenticate_user!
  
  # GET /users.json
  def index
    @users = User.all
    
    respond_to do |format|
      format.json { render json: @users }
    end
  end
  
  # GET /users/deleted.json
  def deleted
    @users = User.where(deleted_at: { "$exists" => true })
    
    respond_to do |format|
      format.json { render json: @users }
    end
  end

  # GET /users/search.json
  def search
    query = ""
    query = params[:q] unless params[:q].blank?

    @users = User.any_of({ first_name: /#{query}/i }, { last_name: /#{query}/i})

    respond_to do |format|
      format.json { render json: @users }
    end
  end
end