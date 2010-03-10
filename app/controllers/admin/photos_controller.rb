class Admin::PhotosController < ApplicationController 
  layout "admin"
  before_filter :login_required
  
  active_scaffold do |config|
      config.actions.exclude :show
      
      config.create.multipart = true
      config.update.multipart = true
      config.columns.exclude :item_file_size, :item_file_name, :item_content_type, :item_updated_at
      config.columns << :item
      
      config.columns = [:item, :caption, :property_id]
      config.actions.exclude :nested
      
#      config.columns[:caption].inplace_edit = true
  end
end