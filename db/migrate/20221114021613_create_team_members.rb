class CreateTeamMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :team_members, id: false, :primary_key => :id do |t|
      t.string :id
      t.references :team, null: false, foreign_key: true
      t.boolean :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
