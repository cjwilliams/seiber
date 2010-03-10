class PagesController < ApplicationController
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