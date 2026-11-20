class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.string :slug, null: false
      t.integer :editor, null: false, default: 0
      t.text :description
      # Set when the project is a remix (a fork of another project's repository).
      t.references :forked_from, foreign_key: { to_table: :projects }

      t.timestamps
    end
    add_index :projects, [ :owner_id, :slug ], unique: true
  end
end
