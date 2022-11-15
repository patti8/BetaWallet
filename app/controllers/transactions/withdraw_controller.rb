class Transactions::WithdrawController < DashboardController

    def new

        if params[:team].present?
                
            @transaction = Transaction::Withdraw.new

            @withdraw = Transaction.where(
                target_wallet: params[:team]
            )
        else
            redirect_to root_path
        end
    end

    def create
        
        @transaction = Transaction::Withdraw.new(withdraw_params)
        
        stock = Team.find_by(id: @transaction.source_wallet)

        if !@transaction.amount.present?
            @transaction.amount = 0
        end

        @transaction.stock = stock.balance

        respond_to do |format|
            if @transaction.save

                stock_source = Team.find_by(id: @transaction.source_wallet)
                stock_target = Stock.find_by(user_id: @transaction.target_wallet)
                
                if stock_target.update(balance:@transaction.amount + stock_target.balance)
                    @transaction.update(status: 2)
                    
                    if stock_source.update(balance: stock_source.balance - @transaction.amount)
                        format.html {redirect_to new_transactions_withdraw_path(:team =>  @transaction.target_wallet), notice:  "Successfully", turbo: false}
                    end
    
                end

            else
                format.html {redirect_to new_transactions_withdraw_path(:team =>  @transaction.target_wallet) , status: :unprocessable_entity, flash: {error: @transaction.errors.full_messages}}
            end
        end
    end

    private
        def withdraw_params
            params.require(:transaction_withdraw).permit(
                :target_wallet,
                :source_wallet,
                :amount
            )
        end
end
