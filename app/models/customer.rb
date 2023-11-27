class Customer < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :address, presence: true
  
    has_many :subscription_customers
    has_many :subscriptions, through: :subscription_customers
end