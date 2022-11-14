class ChangeTypeReferenceToString < ActiveRecord::Migration[7.0]
  def change

    # remove_column :stocks, :user_id
    # remove_column :team_members, :team_id
    remove_column :team_members, :user_id

    # add_column :stocks, :user_id, :string , references: :user
    # add_column :team_members, :team_id, :string , references: :team
    add_column :team_members, :user_id, :string , references: :user

    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
