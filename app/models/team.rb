class Team < ApplicationRecord

    self.primary_key = 'id'
    
    # before_create :add_default_member
    
    # belongs_to :team_member
    has_many :team_members, class_name: "team_members"
    has_one :user

   
    # def add_default_member
    #     member = TeamMember.new
    #     member.user_id = self.team_owner
    #     member.team_id = self.id
    #     member.save!
    # end

end
