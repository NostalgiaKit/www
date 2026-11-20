# Launchpad-style blueprint: a feature spec that is agreed on before it is built.
class Blueprint < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User"

  enum :definition_status, { new: 0, discussion: 1, drafting: 2, review: 3, approved: 4, obsolete: 5 },
    prefix: :definition, validate: true
  enum :implementation_status, { unknown: 0, not_started: 1, started: 2, slow_progress: 3,
                                 good_progress: 4, blocked: 5, implemented: 6 },
    prefix: :implementation, validate: true

  validates :name, presence: true, uniqueness: { scope: :project_id },
    format: { with: /\A[a-z0-9][a-z0-9-]*\z/ }
  validates :title, presence: true

  def to_param = name
end
