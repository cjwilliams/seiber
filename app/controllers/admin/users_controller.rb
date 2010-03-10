class Admin::UsersController < ApplicationController
  layout "admin"
  before_filter :login_required  
  before_filter :check_for_last, :only => :destroy
  
  active_scaffold do |config|
    config.columns = [:login, :password, :password_confirmation, :email]
    list.columns.exclude [:password, :password_confirmation]
    config.actions.exclude :show
  end
  
  def check_for_last
    @users = User.all
    
    if @users.length < 2
      redirect_to :action => :list
    end
  end
end
