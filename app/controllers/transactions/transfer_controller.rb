class Transactions::TransferController < DashboardController

    def friend

        if params[:search_username].present? 

            @target_wallet = User.where(username: params[:search_username]).where.not(username: current_user.username).first
        end

        if @target_wallet.present?

            @transfer = Transaction::Transfer.new

        else
            render :json => {data: "tidak ditemukan"}
        end

    end

    def sendMoney
        stock = Stock.find_by(user_id: current_user.id)
        
        @transfer = Transaction::Transfer.new(transfer_params)
        
        @transfer.status = 1
        @transfer.source_wallet = current_user.id
        @transfer.stock = stock.balance
        
        if @transfer.save
            
            stock_target = Stock.find_by(user_id: @transfer.target_wallet)
            stock_source = Stock.find_by(user_id: @transfer.source_wallet)
            
            if stock_target.update(balance: @transfer.amount + stock_target.balance)
                @transfer.update(status: 2)
                
                if stock_source.update(balance: stock_source.balance - @transfer.amount)
                    redirect_to root_path, notice: "Transfer Success", turbo: false
                end

            end
        else
            # debugger
            puts @transfer.errors.full_messages
            redirect_to transactions_toFriend_path, status: :unprocessable_entity, turbo: false

        end

    end


    private

        def transfer_params
            params.require(:transaction_transfer).permit(
                :target_wallet,
                :source_wallet,
                :amount
            )
        end

end