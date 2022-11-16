class Team < ApplicationRecord

    self.primary_key = 'id'

    attribute :balance, default: 25000000
    
    has_many :team_members
    has_one :user

end
