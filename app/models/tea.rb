class Tea < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :temperature, presence: true
    validates :brew_time, presence: true
  
    has_many :tea_subscriptions
    has_many :subscriptions, through: :tea_subscriptions
end