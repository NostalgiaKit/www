# Loads @owner and @project from /~:user_username/:project_slug routes.
module ProjectScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_project
    layout "project"
  end

  private

  def set_project
    @owner = User.find_by!(username: params[:user_username])
    @project = @owner.projects.find_by!(slug: params[:project_slug] || params[:slug])
  end
end
