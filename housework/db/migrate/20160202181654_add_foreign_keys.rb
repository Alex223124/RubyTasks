class AddForeignKeys < ActiveRecord::Migration
  def change
    add_column :tasks, :user_id, :integer
    add_column :estimations, :task_id, :integer
    add_column :marks, :task_id, :integer
  end
end
