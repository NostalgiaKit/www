class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params[:user_username])
    @projects = @user.projects.order(updated_at: :desc)
  end
end
