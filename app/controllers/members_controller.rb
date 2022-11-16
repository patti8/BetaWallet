class MembersController < DashboardController

    before_action :find_team_member_by_id, only: :show
    before_action :validation_adding_member

    def new
        @team = Team.find_by(id: params[:team_id])
        @user = User.where("username LIKE '%#{params[:search_username]}%' ")

        @team_member = TeamMember.new
    end

    def create
        
        @team_member = TeamMember.new(team_member_params)
        user = User.find_by(id: @team_member.user_id)
        
        respond_to do |format|
            if @team_member.save
                format.html { redirect_to new_team_member_path, notice: "Successfully added #{user.username} to member." }
            else
                format.html { redirect_to new_team_member_path , status: :unprocessable_entity, flash: {error: @team_member.errors.full_messages} }
            end
        end
        

    end

    private 

        def find_team_member_by_id
            @team_member = TeamMember.find(params[:id])
        end

        def validation_adding_member
            
            team = Team.find_by(id: params[:team_id])
            
            if team.team_owner != current_user.id
                redirect_to teams_path, notice: "you don't have access."
            end

        end

        def team_member_params
            params.require(:team_member).permit(:user_id, :team_id)
        end

end
