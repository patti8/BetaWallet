class Transaction::Validator < ActiveModel::Validator

    def validate(record)
        
        if record.amount >= record.stock
            record.errors.add :base, "balance is not enough."
        elsif record.amount  <= 4999
            record.errors.add :base, "minimal transfer must be Rp. 5,000."
        end

    end

end