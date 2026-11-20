# A Scratch or Snap! project. Its source lives in a bare Git repository on disk
# (see Git::ProjectRepository); this row holds the metadata the web UI needs.
class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :forked_from, class_name: "Project", optional: true

  has_many :remixes, class_name: "Project", foreign_key: :forked_from_id, inverse_of: :forked_from
  has_many :pull_requests, dependent: :destroy
  has_many :issues, dependent: :destroy
  has_many :blueprints, dependent: :destroy

  # scratch: project.json (Scratch 3 format) at the repository root.
  # snap:    project.xml at the repository root.
  enum :editor, { scratch: 0, snap: 1 }, validate: true

  validates :name, :slug, presence: true
  validates :slug, uniqueness: { scope: :owner_id }

  def to_param = slug

  def repository
    Git::ProjectRepository.new(self)
  end
end
