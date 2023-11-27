class Subscription < ApplicationRecord
    validates :title, presence: true
    validates :price, presence: true
    validates :frequency, presence: true
  
    has_many :subscription_customers
    has_many :customers, through: :subscription_customers
    has_many :tea_subscriptions
    has_many :teas, through: :tea_subscriptions
end