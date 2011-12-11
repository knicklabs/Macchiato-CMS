class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource
  
  private
  
  def layout_by_resource
    if devise_controller?
      "application"
    elsif params[:controller] == "admin"
      "admin"
    else
      "application"
    end
  end
end
