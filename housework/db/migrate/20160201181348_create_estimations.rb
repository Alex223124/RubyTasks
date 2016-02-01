class CreateEstimations < ActiveRecord::Migration
  def change
    create_table :estimations do |t|
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
