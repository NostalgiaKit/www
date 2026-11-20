class ProjectsController < ApplicationController
  include ProjectScoped
  skip_before_action :set_project, only: :index
  layout "application", only: :index

  def index
    @projects = Project.includes(:owner).order(updated_at: :desc).limit(60)
  end

  def show
  end
end
