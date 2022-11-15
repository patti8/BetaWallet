class TeamMember < ApplicationRecord

  self.primary_key = 'id'

  has_one :user, foreign_key: "id", primary_key: "user_id"
  # has_one :team, foreign_key: "id", primary_key: "team_id"
  belongs_to :team, class_name: "team", foreign_key: "team_id"
  
  validates :user_id, uniqueness: {scope: :team_id}

  validate :validate_team_member

  def validate_team_member
    if Team.where(:team_owner => user_id, :id => team_id).any?
      errors.add(:user_id, "already team")
    end
  end
  
end
