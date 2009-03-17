class EmailsController < ApplicationController
  def index
    @emails = Email.find(:all, :conditions => {:sent => 'false'}, :order => "created_at DESC")
  end
  
  def sent
    @emails = Email.find(:all, :conditions => {:sent => 'true'}, :order => "created_at DESC")
  end

  def show
    @email = Email.find(params[:id])
    @email.read = true
  end

  def new
    @email = Email.new
  end
  
  def create
    @email = Email.new(params[:email])
    
    if @email.save
      redirect_to root_path
    else
      flash[:error] = "An error occured while trying to send. Please try again."
      redirect_to new_email_path
    end
  end

  def reply
    @email_original = Email.find(params[:id])
    @email_original.replied = true
    @email = Email.new
  end
  
  def send
    @email = Email.new(params[:email])
  end
  
  def destroy
    @email = Email.find(params[:id])
    
    if @email.destroy
      flash[:notice] = "Email deleted successfully"
      redirect_to emails_path
    else
      flash[:error] = "An error occured while trying to delete."
      redirect_to emails_path
    end
  end
  
  def mark_unread
    @email = Email.find(params[:id])
    @email.read = false
    redirect_to emails_path
  end
  
  def mark_read
    @email = Email.find(paras[:id])
    @email.read = true
    redirect_to emails_path
  end
end
