class PhotosController < ApplicationController 
  def index
    @photos = Photo.find(:all)
    render :layout => "application"
  end

  def public
    @photo = Photo.find(params[:id])
    render :layout => "application"
  end
end