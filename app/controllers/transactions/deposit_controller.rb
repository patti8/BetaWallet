class Transactions::DepositController < DashboardController

    def history
        
        if params[:id_team].present?
            
            @team = Team.find_by(id: params[:id_team])

            @deposit = Transaction::Deposit.where(
                target_wallet: params[:id_team]
            ).order(created_at: :desc)

        end
    end

    def create
        @transaction_deposit = Transaction::Deposit.new(deposit_params)
        
        stock = Stock.find_by(user_id: current_user.id)

        if !@transaction_deposit.amount.present?
            @transaction_deposit.amount = 0
        end

        @transaction_deposit.stock = stock.balance

        respond_to do |format|
            if @transaction_deposit.save

                stock_target = Team.find_by(id: @transaction_deposit.target_wallet)
                stock_source = Stock.find_by(user_id: @transaction_deposit.source_wallet)
                
                if stock_target.update(balance:@transaction_deposit.amount + stock_target.balance)
                    @transaction_deposit.update(status: 2)
                    
                    if stock_source.update(balance: stock_source.balance - @transaction_deposit.amount)
                        format.html {redirect_to team_path(@transaction_deposit.target_wallet), notice:  "Successfully"}
                    end
    
                end

            else
                format.html {redirect_to team_path(@transaction_deposit.target_wallet) , status: :unprocessable_entity, flash: {error: @transaction_deposit.errors.full_messages}}
            end
        end
    end

    private
        def deposit_params
            params.require(:transaction_deposit).permit(
                :target_wallet,
                :source_wallet,
                :amount
            )
        end
end
