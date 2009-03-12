class PhotosController < ApplicationController 
  skip_before_filter :login_required, :only => [:index, :public]
  layout "admin", :except => [:index, :public]
  
  skip_before_filter :verify_authenticity_token
  
  active_scaffold :photos do |config|
      config.create.multipart = true
      config.update.multipart = true
      config.columns.exclude :item_file_size, :item_file_name, :item_content_type, :type
      config.columns << :item
      
      config.list.columns = [:item, :caption]
      
      config.columns[:property].form_ui = :select
      
#      config.columns[:caption].inplace_edit = true
  end
  
  def index
    @photos = Photo.find(:all)
    render :layout => "application"
  end

  def public
    @photo = Photo.find(params[:id])
    render :layout => "application"
  end
end