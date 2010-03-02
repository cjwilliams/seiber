class PagesController < ApplicationController
  uses_tiny_mce
    
  skip_before_filter :login_required, :only => [:index, :show]
  layout "admin", :except => [:show]
  
  active_scaffold :pages do |config|
      config.actions.exclude :show
      
      config.list.columns = [:title, :updated_at]
      config.columns = [:title, :content]
      
      config.columns[:content].form_ui = :text_editor
  end
  
  def index
    redirect_to :action => :list
  end
  
  def show
    @title = params[:title].gsub('-', " ")
    @page = Page.find_by_title(@title)
    if @page.nil?
      redirect_to :root
    else
      render :layout => "application"
    end
  end
end
