class CreateSubscriptionCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_customers do |t|
      t.references :subscription, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.integer :status, default: 2

      t.timestamps
    end
  end
end
