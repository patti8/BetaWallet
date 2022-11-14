class Stock < ApplicationRecord
  
  # validates_presence_of :user_id, on: :create, message: "can't be blank"
  belongs_to :user
  validates_uniqueness_of :user_id, on: :create, message: "must be unique"
end
