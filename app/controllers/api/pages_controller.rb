class Api::PagesController < ApplicationController
  # Only authorized users may access this resource.
  before_filter :authenticate_user!
  
  # GET /Pages.json
  def index
    @pages = Page.all.where({ user_id: current_user.id })
    
    respond_to do |format|
      format.json { render json: @pages }
    end
  end
  
  # GET /Pages/deleted.json
  def deleted
    @pages = Page.where({ user_id: current_user.id, deleted_at: { "$exists" => true } })
    
    respond_to do |format|
      format.json { render json: @pages }
    end
  end
  
  # GET /Pages/published.json
  def published
    @pages = Page.where({ user_id: current_user.id, published: true })
    
    respond_to do |format|
      format.json { render json: @pages }
    end
  end
  
  # GET /Pages/unpublished.json
  def unpublished
    @pages = Page.where({ user_id: current_user.id, published: false })
    
    respond_to do |format|
      format.json { render json: @pages }
    end
  end
  
  # GET /Pages/search.json
  def search
    query = ""
    query = params[:q] unless params[:q].blank?
    
    @pages = Page.where({ title: /#{query}/i })
    
    respond_to do |format|
      format.json { render json: @pages }
    end
  end
  
  # GET /Pages/count.json
  def count
    @count = 0
    
    type = ""
    type = params[:type] unless params[:type].blank?
  
    if type.downcase == "published"
      @count = Page.count(conditions: { published: true }) 
    elsif type.downcase == "unpublished"
      @count = Page.count(conditions: { user_id: current_user.id, published: false })
    elsif type.downcase == "deleted"
      @count = Page.count(conditions: { user_id: current_user.id, deleted_at: { "$exists" => true } })  
    elsif type.downcase == "search"
      query = ""
      query = params[:q] unless params[:q].blank?
      
      @count = Page.count(conditions: { user_id: current_user.id, title: /#{query}/i })
    else
      @count = Page.count(conditions: { user_id: current_user.id })
    end  
    
    respond_to do |format|
      format.json { render json: @count }
    end
  end
  
  # GET /Pages/1.json
  def show
    @page = current_user.Pages.find(params[:id])
    
    respond_to do |format|
      format.json { render json: @page }
    end
  end
  
  # Page /Pages.json
  def create
    @page = Page.new(params[:Page])
    @page.user = current_user
    
    respond_to do |format|
      if @page.save
        format.json { render json: @page, status: :created, location: [:admin, @page] }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /Pages/1.json
  def update
    @page = current_user.Pages.find(params[:id])
  
    respond_to do |format|
      if @page.update_attributes(params[:Page])
        format.json { head :ok }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end  
  
  # DELETE /Pages/1.json
  def destroy
    @page = current_user.Pages.find(params[:id])
    @page.destroy
    
    respond_to do |format|
      format.json { head :ok }
    end
  end
  
  # PUT /admin/Pages/1/restore.json
  def restore
    @page = current_user.Pages.find(params[:id])
    @page.restore
    
    respond_to do |format|
      format.json { head :ok }
    end
  end  
end