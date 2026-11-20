class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :display_name
      t.text :bio

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
