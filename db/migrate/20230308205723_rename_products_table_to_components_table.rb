class RenameProductsTableToComponentsTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :products, :components
  end
end
