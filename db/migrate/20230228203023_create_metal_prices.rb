class CreateMetalPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :metal_prices do |t|
      t.decimal :gold
      t.decimal :platinum
      t.decimal :silver
      t.decimal :palladium

      t.timestamps
    end
  end
end
