# Asynchronous collaboration: remixes come back to the original as pull requests.
class PullRequest < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User"
  belongs_to :source_project, class_name: "Project"

  enum :state, { open: 0, merged: 1, closed: 2 }, validate: true

  validates :title, :source_branch, :target_branch, presence: true

  # TODO: diff (Git::ProjectRepository#diff), mergeable?, merge!
end
