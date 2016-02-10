class AddUserPerformIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :user_perform_id, :integer
  end
end
