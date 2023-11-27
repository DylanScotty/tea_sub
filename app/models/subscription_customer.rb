class SubscriptionCustomer < ApplicationRecord
    belongs_to :subscription
    belongs_to :customer
  
    enum status: { cancelled: 0, active: 1 }
end