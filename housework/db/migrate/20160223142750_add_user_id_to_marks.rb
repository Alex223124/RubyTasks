class AddUserIdToMarks < ActiveRecord::Migration
  def change
    add_column :marks, :user_id, :integer
  end
end
