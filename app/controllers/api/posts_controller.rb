class Api::PostsController < ApplicationController
  # Only authorized users may access this resource.
  before_filter :authenticate_user!
  
  # GET /posts.json
  def index
    @posts = Post.all
    
    respond_to do |format|
      format.json { render json: @posts }
    end
  end
  
  # GET /posts/deleted.json
  def deleted
    @posts = Post.where({ deleted_at: { "$exists" => true } })
    
    respond_to do |format|
      format.json { render json: @posts }
    end
  end
  
  # GET /posts/published.json
  def published
    @posts = Post.where({ published: true })
    
    respond_to do |format|
      format.json { render json: @posts }
    end
  end
  
  # GET /posts/unpublished.json
  def unpublished
    @posts = Post.where({ published: false })
    
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
      @count = Post.count(conditions: { published: false })
    elsif type.downcase == "deleted"
      @count = Post.count(conditions: { deleted_at: { "$exists" => true } })  
    elsif type.downcase == "search"
      query = ""
      query = params[:q] unless params[:q].blank?
      
      @count = Post.count(conditions: { title: /#{query}/i })
    else
      @count = Post.count
    end  
    
    respond_to do |format|
      format.json { render json: @count }
    end
  end
  
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    
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
    @post = Post.find(params[:id])
  
    unless params[:meta_names].blank?
      params[:meta_names].each_with_index do |meta_name, index|
        if meta_name[:id] and meta_name[:_delete] == true
          meta = @post.meta_names.find(meta_name[:id])
          meta.delete
          params[:meta_names][index] = nil
        end
        if meta_name[:key].blank? and meta_name[:value].blank?
          params[:meta_names][index] = nil
        end
      end
    end
    
    unless params[:custom_fields].blank?
      params[:custom_fields].each_with_index do |custom_field, index|
        if custom_field[:id] and custom_field[:_delete] == true
          field = @post.custom_fields.find(custom_field[:id])
          field.delete
          params[:custom_fields][index] = nil
        end
        if custom_field[:key].blank? and custom_field[:value].blank?
          params[:custom_fields][index] = nil
        end
      end
    end
  
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.json { render json: @post, status: :ok }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end  
  
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    respond_to do |format|
      format.json { head :ok }
    end
  end
  
  # PUT /admin/posts/1/restore.json
  def restore
    @post = Posts.find(params[:id])
    @post.restore
    
    respond_to do |format|
      format.json { head :ok }
    end
  end  
end