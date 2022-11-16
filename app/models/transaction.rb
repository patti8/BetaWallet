# STATUS REF
#  1 : PENDING
#  0 : CANCEL
#  2 : SUCCESS

class Transaction < ApplicationRecord

    attr_accessor :stock
    attribute :status, default: 1

    validates_uniqueness_of :id, on: :create, message: "must be unique"
    
    validates_presence_of :amount
    validates_presence_of :source_wallet 
    validates_presence_of :target_wallet

    validates_with Transaction::Validator

end
