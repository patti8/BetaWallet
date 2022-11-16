module TransactionHelper
    
    def self.user_or_team_description(value)
        @team = Team.find_by(id: value)
        @user = User.find_by(id: value)

        if @team.present? 
             @team.team_name 
        else 
            @user.first_name.upcase + " " + @user.last_name.upcase 
        end

    end

    def self.type_description(value)
        @team = Team.find_by(id: value)

        if @team.present? 
           "TEAM"
        end
    end

end
