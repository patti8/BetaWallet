class TeamsController < DashboardController

    before_action :find_team_by_id, only: :show

    def index
    end

    def new
        @team = Team.new
    end

    def create
        
        @team = current_user.teams.build(team_params)
        @team.id = SecureRandom.uuid
        @team.team_owner = current_user.id

        if @team.save
            redirect_to teams_path, notice: "Successfully added team."
        else
            redirect_to new_team_path , status: :unprocessable_entity, flash: {error: @team.errors.full_messages}
        end

    end

    def show
        
        @transaction_deposit = Transaction::Deposit.new

        @owner = User.find_by(id: @team.team_owner)
        @members = TeamMember.where(team_id: @team.id)

    end

    def edit
        
    end

    def update

    end

    def destroy

    end

    private 

        def find_team_by_id
            @team = Team.find(params[:id])
        end

        def team_params
            params.require(:team).permit(:team_name, :team_owner, :description, :balance)
        end

end
