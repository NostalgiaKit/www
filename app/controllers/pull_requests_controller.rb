class PullRequestsController < ApplicationController
  include ProjectScoped

  def index
    @pull_requests = @project.pull_requests.order(created_at: :desc)
  end

  def show
    @pull_request = @project.pull_requests.find(params[:id])
  end
end
