class AddIndexForParentChildIds < ActiveRecord::Migration
  def change
    add_index :relationships, [:parent_id, :child_id], unique: true
  end
end
