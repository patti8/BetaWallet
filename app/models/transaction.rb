# STATUS REF
#  1 : PENDING
#  0 : CANCEL
#  2 : SUCCESS

class Transaction < ApplicationRecord

    attr_accessor :stock

    validates_uniqueness_of :id, on: :create, message: "must be unique"
    
    validates_presence_of :source_wallet #, on: :create, message: ""
    validates_presence_of :target_wallet


end
