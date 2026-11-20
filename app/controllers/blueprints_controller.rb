class BlueprintsController < ApplicationController
  include ProjectScoped

  def index
    @blueprints = @project.blueprints.order(:name)
  end

  def show
    @blueprint = @project.blueprints.find_by!(name: params[:name])
  end
end
