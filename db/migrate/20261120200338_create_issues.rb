class CreateIssues < ActiveRecord::Migration[8.1]
  def change
    create_table :issues do |t|
      t.references :project, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.integer :number, null: false
      t.string :title, null: false
      t.text :body
      t.integer :status, null: false, default: 0
      t.integer :importance, null: false, default: 0

      t.timestamps
    end
    add_index :issues, [ :project_id, :number ], unique: true
  end
end
