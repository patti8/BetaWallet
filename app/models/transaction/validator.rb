class Transaction::Validator < ActiveModel::Validator

    def validate(record)
        
        if record.amount >= record.stock
            record.errors.add :base, "your balance is not enough."
        elsif record.amount  <= 4999
            record.errors.add :base, "maximal transfer must Rp. 5,000."
        end
    end

end