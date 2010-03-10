class PhotosController < ApplicationController 
  skip_before_filter :login_required
  
  def index
    @photos = Photo.find(:all)
    render :layout => "application"
  end

  def public
    @photo = Photo.find(params[:id])
    render :layout => "application"
  end
end