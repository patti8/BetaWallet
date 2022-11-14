class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams, id: false, :primary_key => :id do |t|
      t.string :id
      t.string :team_name
      t.string :team_owner
      t.string :description
      t.decimal :balance

      t.timestamps
    end
  end
end
