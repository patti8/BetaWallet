class ChangeColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :stocks, :id, :string
    change_column :transactions, :id, :string
    change_column :users, :id, :string
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
