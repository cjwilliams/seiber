class Admin::PagesController < ApplicationController
  uses_tiny_mce
    
  layout "admin"
  before_filter :login_required
  
  active_scaffold :pages do |config|
      config.actions.exclude :show
      
      config.list.columns = [:title, :updated_at]
      config.columns = [:title, :content]
      
      config.columns[:content].form_ui = :text_editor
  end
end
