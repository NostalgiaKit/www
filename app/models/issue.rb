# Launchpad-style bug. Status and importance follow Launchpad's names.
class Issue < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User"

  enum :status, {
    new: 0, incomplete: 1, confirmed: 2, triaged: 3, in_progress: 4,
    fix_committed: 5, fix_released: 6, invalid: 7, wont_fix: 8
  }, prefix: true, validate: true
  enum :importance, { undecided: 0, wishlist: 1, low: 2, medium: 3, high: 4, critical: 5 },
    prefix: true, validate: true

  validates :title, presence: true
  validates :number, presence: true, uniqueness: { scope: :project_id }

  # TODO: assign `number` per project on create.

  def to_param = number.to_s
end
