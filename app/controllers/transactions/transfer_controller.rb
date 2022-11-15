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
        @target_wallet = User.where(username: params[:search_username]).where.not(username: current_user.username).first

        stock = Stock.find_by(user_id: current_user.id)
        
        @transfer = Transaction::Transfer.new(transfer_params)
        
        if !@transfer.amount.present?
            @transfer.amount = 0
        end

        @transfer.status = 1
        @transfer.source_wallet = current_user.id
        @transfer.stock = stock.balance
        
        respond_to do |format|
            
            if @transfer.save
                
                stock_target = Stock.find_by(user_id: @transfer.target_wallet)
                stock_source = Stock.find_by(user_id: @transfer.source_wallet)
                
                if stock_target.update(balance: @transfer.amount + stock_target.balance)
                    @transfer.update(status: 2)
                    
                    if stock_source.update(balance: stock_source.balance - @transfer.amount)
                        format.html {redirect_to root_path, notice: "Transfer Success", turbo: false}
                    end

                end
            else
                format.html {redirect_to transactions_toFriend_path , status: :unprocessable_entity, flash: {error: @transfer.errors.full_messages}}

            end
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