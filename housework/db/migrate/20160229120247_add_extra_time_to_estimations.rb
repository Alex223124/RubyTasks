class AddExtraTimeToEstimations < ActiveRecord::Migration
  def change
    add_column :estimations, :extra_time, :time
  end
end
