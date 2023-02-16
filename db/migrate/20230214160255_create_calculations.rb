class CreateCalculations < ActiveRecord::Migration[7.0]
  def change
    create_table :calculations do |t|
      t.string :type
      t.string :name
      t.float :weight
      t.float :cost
      t.date :release_date
      t.string :condition

      t.timestamps
    end
  end
end
