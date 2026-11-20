class CreateBlueprints < ActiveRecord::Migration[8.1]
  def change
    create_table :blueprints do |t|
      t.references :project, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.string :title, null: false
      t.text :summary
      t.integer :definition_status, null: false, default: 0
      t.integer :implementation_status, null: false, default: 0

      t.timestamps
    end
    add_index :blueprints, [ :project_id, :name ], unique: true
  end
end
