class ForumTopic < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :posts, class_name: "ForumPost", dependent: :destroy

  validates :title, presence: true
end
