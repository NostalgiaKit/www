class CreateForumPosts < ActiveRecord::Migration[8.1]
  def change
    create_table :forum_posts do |t|
      t.references :forum_topic, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.text :body_bbcode, null: false

      t.timestamps
    end
  end
end
