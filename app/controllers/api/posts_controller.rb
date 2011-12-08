class Admin::PostsController < ApplicationController
  # Only authorized users may access this resource.
  before_filter :authenticate_user!
  
  # GET /posts.json
  def index
    @posts = Post.all.where({ user_id: current_user.id })
    
    respond_to do |format|
      format.json { render json: @posts }
    end
  end
  
  # GET /posts/deleted.json
  def deleted
    @posts = Post.where({ user_id: current_user.id, deleted_at: { "$exists" => true } })
    
    respond_to do |format|
      format.json { render json: @posts }
    end
  end
  
  # GET /posts/published.json
  def published
    @posts = Post.where({ user_id: current_user.id, published: true })
    
    respond_to do |format|
      format.json { render json: @posts }
    end
  end
  
  # GET /posts/unpublished.json
  def unpublished
    @posts = Post.where({ user_id: current_user.id, published: false })
    
    respond_to do |format|
      format.json { render json: @posts }
    end
  end
  
  # GET /posts/search.json
  def search
    query = ""
    query = params[:q] unless params[:q].blank?
    
    @posts = Post.where({ title: /#{query}/i })
    
    respond_to do |format|
      format.json { render json: @posts }
    end
  end
  
  # GET /posts/count.json
  def count
    @count = 0
    
    type = ""
    type = params[:type] unless params[:type].blank?
  
    if type.downcase == "published"
      @count = Post.count(conditions: { published: true }) 
    elsif type.downcase == "unpublished"
      @count = Post.count(conditions: { user_id: current_user.id, published: false })
    elsif type.downcase == "deleted"
      @count = Post.count(conditions: { user_id: current_user.id, deleted_at: { "$exists" => true } })  
    elsif type.downcase == "search"
      query = ""
      query = params[:q] unless params[:q].blank?
      
      @count = Post.count(conditions: { user_id: current_user.id, title: /#{query}/i })
    else
      @count = Post.count(conditions: { user_id: current_user.id })
    end  
    
    respond_to do |format|
      format.json { render json: @count }
    end
  end
  
  # GET /posts/1.json
  def show
    @post = current_user.posts.find(params[:id])
    
    respond_to do |format|
      format.json { render json: @post }
    end
  end
  
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    
    respond_to do |format|
      if @post.save
        format.json { render json: @post, status: :created, location: [:admin, @post] }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1.json
  def update
    @post = current_user.posts.find(params[:id])
  
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.json { head :ok }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end  
  
  # DELETE /posts/1.json
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    
    respond_to do |format|
      format.json { head :ok }
    end
  end
  
  # PUT /admin/posts/1/restore.json
  def restore
    @post = current_user.posts.find(params[:id])
    @post.restore
    
    respond_to do |format|
      format.json { head :ok }
    end
  end  
end