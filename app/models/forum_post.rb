class ForumPost < ApplicationRecord
  belongs_to :forum_topic
  belongs_to :author, class_name: "User"

  validates :body_bbcode, presence: true

  def body_html
    Bbcode::Renderer.new(body_bbcode).to_html
  end
end
