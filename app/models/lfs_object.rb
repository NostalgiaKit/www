# A deduplicated binary asset, addressed by its SHA-256 (the Git LFS oid).
# Projects reference it through LFS pointer files committed to their repositories.
class LfsObject < ApplicationRecord
  has_one_attached :file

  validates :oid, presence: true, uniqueness: true, format: { with: /\A\h{64}\z/ }
  validates :md5, presence: true, format: { with: /\A\h{32}\z/ }
  validates :size, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # TODO: LfsObject.store!(io) that hashes, dedupes and attaches in one step.
end
