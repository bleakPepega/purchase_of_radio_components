class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :group
      t.string :subgroup
      t.string :name
      t.float :gold
      t.float :silver
      t.float :platinum
      t.float :mpg
      t.timestamps
    end
  end
end
