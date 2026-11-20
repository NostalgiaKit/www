# One row per unique binary asset (costume, sound), shared by every project that
# uses it. The bytes live in Active Storage; Git only holds LFS pointer files.
class CreateLfsObjects < ActiveRecord::Migration[8.1]
  def change
    create_table :lfs_objects do |t|
      # SHA-256 hex digest: the Git LFS object id.
      t.string :oid, null: false
      t.integer :size, limit: 8, null: false
      # MD5 hex digest, which vanilla Scratch uses for asset file names in .sb3 exports.
      t.string :md5, null: false

      t.timestamps
    end
    add_index :lfs_objects, :oid, unique: true
    add_index :lfs_objects, :md5
  end
end
