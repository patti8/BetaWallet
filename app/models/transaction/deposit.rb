class  Transaction::Deposit < Transaction
    validates_with Transaction::Validator
end
