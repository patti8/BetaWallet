class Team < ApplicationRecord

    self.primary_key = 'id'
    
    has_many :team_members
    has_one :user

end
