class User < ApplicationRecord
  # Phase 1 federation: every user is an ActivityPub Person.
  # TODO: acts_as_federails_actor username_field: :username, name_field: :display_name, ...

  has_many :projects, foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy
  has_many :issues, foreign_key: :author_id, inverse_of: :author
  has_many :pull_requests, foreign_key: :author_id, inverse_of: :author
  has_many :forum_posts, foreign_key: :author_id, inverse_of: :author

  validates :username, presence: true, uniqueness: true

  def to_param = username
end
