class User < ApplicationRecord

  has_one :stock, class_name: "stock", foreign_key: "stock_id"
  
  validates :username, 
            length: {minimum:3, maximum:8, message: "minimum character 3 and max character 8"},
            format: { without: /\s/, message: "must contain no spaces" }

  validates_uniqueness_of :national_id, on: :create, message: "must be unique"
  validates_uniqueness_of :username, on: :create, message: "already exists."

  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :national_id
  validates_presence_of :username

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
end
