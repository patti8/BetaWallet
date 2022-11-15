class Transactions::Tools

    def self.calculators(value, transfer, format)

        if transfer==true

            stock_target = Stock.find_by(user_id: value.target_wallet)
            stock_source = Stock.find_by(user_id: value.source_wallet)
            
            if stock_target.update(balance:value.amount + stock_target.balance)
                value.update(status: 2)
                
                if stock_source.update(balance: stock_source.balance - value.amount)
                    format.html {redirect_to root_path, notice: "Transfer Success", turbo: false}
                end

            end
            
        else
            stock_target = Team.find_by(id: value.target_wallet)
            stock_source = Stock.find_by(user_id: value.source_wallet)
            
            if stock_target.update(balance:value.amount + stock_target.balance)
                value.update(status: 2)
                
                stock_source.update(balance: stock_source.balance - value.amount)
                    format.html {redirect_to team_path, notice:  "Successfully"}
                

            end
        end
    end

end