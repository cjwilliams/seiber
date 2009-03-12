class PagesController < ApplicationController
  skip_before_filter :login_required, :only => [:index, :show]
  layout "admin", :except => [:show]
  
  active_scaffold :pages do |config|
      config.actions.exclude :show
      
      config.list.columns = [:title, :updated_at]
      config.columns = [:title, :content]
      
      config.columns[:content].form_ui = :textarea
  end
  
  uses_tiny_mce(:options => {:theme => 'advanced',
    :browsers => %w{msie gecko},
    :theme_advanced_toolbar_location => "top",
    :theme_advanced_toolbar_align => "left",
    :theme_advanced_resizing => true,
    :theme_advanced_resize_horizontal => false,
    :paste_auto_cleanup_on_paste => true,
    :theme_advanced_buttons1 => %w{bold italic underline strikethrough | justifyleft justifycenter justifyright justifyfull | styleselect formatselect fontselect fontsizeselect},
    :theme_advanced_buttons2 => %w{cut copy paste pastetext pasteword | search replace | bullist numlist | outdent indent blockquote | undo redo | link unlink insertimage help code | forecolor backcolor},
    :plugins => %w{safari spellchecker style layer advhr advimage advlink  preview searchreplace contextmenu paste directionality fullscreen xhtmlxtras imagemanager}},
    :only => [:edit])
    
  def index
    redirect_to :action => :list
  end
  
  def show
    @title = params[:title].gsub('-', " ")
    @page = Page.find_by_title(@title)
    render :layout => "application"
  end
end
