class Transactions::TransferController < DashboardController

    def friend

        if params[:username].present? 
            @target_wallet = User.find_by(username: JSON.parse(params[:username]))
        end

        if @target_wallet.present?

            @target_wallet = User.where(username: JSON.parse(params[:username])).first #.where.not(username: current_user.id)

            @transfer = Transaction::Transfer.new(transfer_params)

        else
            render :json => {data: "tidak ditemukan"}
        end

    end

    def sendMoney
        
        
        @transfer = Transaction::Transfer.new(transfer_params)
        @transfer.source_wallet = current_user.id
        @transfer.status = 1
        
        debugger
        
        if @transfer.save
            
            stock_target = Stock.find_by(user_id: transfer.target_wallet)
            
            if stock_target.update(balance: transfer.amount + stock_target.balance)
                transfer.update(status: 2)
            end

        end

    end


    private

        def transfer_params
            params.require(:transaction_transfer).permit(
                :target_wallet,
                # :amount
            )
        end

end