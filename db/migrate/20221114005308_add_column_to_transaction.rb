class AddColumnToTransaction < ActiveRecord::Migration[7.0]
  def change
    
    add_column :transactions, :source_wallet, :string
    add_column :transactions, :target_wallet, :string

  end
end
