class ForumTopicsController < ApplicationController
  def index
    @topics = ForumTopic.includes(:author).order(updated_at: :desc)
  end

  def show
    @topic = ForumTopic.find(params[:id])
    @posts = @topic.posts.includes(:author).order(:created_at)
  end
end
