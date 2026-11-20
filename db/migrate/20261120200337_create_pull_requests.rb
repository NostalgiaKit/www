class CreatePullRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :pull_requests do |t|
      t.references :project, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: :users }
      # The remix the changes come from. Same as project for a branch-to-branch request.
      t.references :source_project, null: false, foreign_key: { to_table: :projects }
      t.string :source_branch, null: false
      t.string :target_branch, null: false
      t.string :title, null: false
      t.text :body
      t.integer :state, null: false, default: 0

      t.timestamps
    end
  end
end
