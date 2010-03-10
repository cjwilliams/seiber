class JobsController < ApplicationController
  def index
    @jobs = Job.find(:all, :conditions => {:status => "Open"})
    render :layout => "application"
  end

  def public
    @job = Job.find(params[:id])
    render :layout => "application"
  end
end
