# STATUS REF
#  1 : PENDING
#  0 : CANCEL
#  2 : SUCCESS

class Transaction < ApplicationRecord


    validates_uniqueness_of :id_transaction, on: :create, message: "must be unique"
    
    validates_presence_of :source_wallet #, on: :create, message: ""
    validates_presence_of :target_wallet

    private

        # SOURCE WALLET WITH CURRENT USER
        def source_wallet
        end

end
