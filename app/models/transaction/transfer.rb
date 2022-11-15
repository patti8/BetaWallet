class  Transaction::Transfer < Transaction
    
    validates_with Transaction::Validator
    
end