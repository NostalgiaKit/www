class IssuesController < ApplicationController
  include ProjectScoped

  def index
    @issues = @project.issues.order(number: :desc)
  end

  def show
    @issue = @project.issues.find_by!(number: params[:number])
  end
end
