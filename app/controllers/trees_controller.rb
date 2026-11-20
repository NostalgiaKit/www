class TreesController < ApplicationController
  include ProjectScoped

  def show
    @path = params[:path].to_s
    # TODO: list entries at @path with @project.repository
  end
end
