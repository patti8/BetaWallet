class MembersController < DashboardController

    before_action :find_team_member_by_id, only: :show

    def index
        @teams = Team.where(
            team_owner: current_user.id
        )
    end

    def new
        @user = User.where("username LIKE '%#{params[:search_username]}%' ")
        @team_member = TeamMember.new
    end

    def create
        
        @team_member = TeamMember.new(team_member_params)
        user = User.find_by(id: @team_member.user_id)
        
        respond_to do |format|
            if @team_member.save
                format.html { redirect_to new_team_member_path, notice: "Successfully added #{user.username} member." }
            else
                format.html { redirect_to new_team_member_path , status: :unprocessable_entity, flash: {error: @team_member.errors.full_messages} }
            end
        end
        

    end

    def show
  
    end

    def edit
        
    end

    def update

    end

    def destroy

    end

    private 

        def find_team_member_by_id
            @team_member = TeamMember.find(params[:id])
        end

        def team_member_params
            params.require(:team_member).permit(:user_id, :team_id)
        end

end
