class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :author_id
      t.text :text

      t.timestamps null: false
    end
  end
end
