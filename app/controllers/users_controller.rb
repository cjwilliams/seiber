class UsersController < ApplicationController
  layout "admin"
  skip_before_filter :login_required
  
  def index
    @users = User.find(:all)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    @user.save!
    self.current_user = @user
    
    redirect_back_or_default('/')
    flash[:notice] = "Thanks for signing up!"
  
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end
  
  def destroy
    @user = User.find(params[:id])
    
    if @user.destroy
      flash[:notice] = "User deleted successfully"
      redirect_to users_path
    else
      flash[:error] = "An error occured while deleting"
      redirect_to users_path
    end
  end
end
