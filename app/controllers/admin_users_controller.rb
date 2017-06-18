class AdminUsersController < ApplicationController
  
  layout 'admin'

  before_action :confirmed_logged_in
  before_action :find_admin_user, :only => [:edit, :update, :delete, :destroy]

  def index
  	@admin_users = AdminUser.sorted
  end

  def new
  	@admin_user = AdminUser.new
  end

  def create
  	@admin_user = AdminUser.new(admin_user_params)
  	if @admin_user.save
  		flash[:notice] = "Admin User successfully created."
  		redirect_to admin_users_path
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	@admin_user.update_attributes(admin_user_params)
  	if @admin_user.save
  		flash[:notice] = "Admin User updated successfully."
  		redirect_to admin_users_path
  	else
  		render :edit
  	end
  end

  def delete
  end

  def destroy
  	@admin_user.destroy
  	flash[:notice] = "Admin User #{@admin_user.username} successfully deleted."
  	redirect_to admin_users_path
  end

  private

  def admin_user_params
  	params.require(:admin_user).permit(:first_name, :last_name, :email, :username, :password)
  end

  def find_admin_user
  	@admin_user = AdminUser.find(params[:id])
  end
end
