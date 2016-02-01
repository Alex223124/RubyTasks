class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.integer :number

      t.timestamps null: false
    end
  end
end
