class UsersController < ApplicationController
  # before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :authenticate, :except => [:new, :create]
  before_filter :admin_user, :except => [:new, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  def index
    @title = t :users_index_title
    
    if current_user.is_admin?
      @users = User.except(:id => current_user.id)
    else
      redirect_to root_path
    end
  end

  def new
    
    @title = t :new_user_title
    @user = User.new
  end

  def create
    if !User.any? || current_user.is_admin?
      @user = User.new(params[:user])
      # @user.admin = true if !User.exists?
      if @user.save
        flash[:notice] = t(:user_created)
        redirect_to users_path
      else
        @title = t :new_user_title
        render :action => 'new'
      end
     else
       redirect_to root_path 
    end
  end
  
  def edit
    @title = t :editing_user
    @user = User.find(params[:id])
#    if (!current_user.is_admin?) && (!current_user?(@user))
#      redirect_to root_path
#    end   
  end

  def update    
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    params[:user].delete(:admin) unless signed_in_as_admin?
    params[:user][:admin] = '1' unless User.any?
    if @user.update_attributes(params[:user])
      flash[:notice] = t(:user_updated)
      redirect_to users_path
    else
      @title = t :editing_user
      render :action => 'edit'
    end
  end

  def destroy
    if Job.exists?(:master_id => params[:id])
      flash[:notice] = t(:user_used)
      redirect_to users_path
    else
      @user = User.find(params[:id])
      if @user.id == params[:id]
        flash[:alert] = "You can't"
        redirect_to users_path
      end
      if @user.destroy
        flash[:notice] = t(:user_deleted)
        redirect_to users_path
      end
    end
  end
  
  def show
    @user = User.find(params[:id])
    # redirect_to users_path
  end
  
  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.is_admin?
    end
end
