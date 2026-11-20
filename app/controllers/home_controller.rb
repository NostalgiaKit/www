class HomeController < ApplicationController
  def index
    @recent_projects = Project.order(updated_at: :desc).limit(12)
  end
end
