class CommitsController < ApplicationController
  include ProjectScoped

  def index
    # TODO: @commits = @project.repository.commits
  end

  def show
    # TODO: @commit and its diff from @project.repository
  end
end
