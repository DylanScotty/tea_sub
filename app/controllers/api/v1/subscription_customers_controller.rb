class Api::V1::SubscriptionCustomersController < ApplicationController
    def index
      customer = Customer.find(params[:customer_id])
      render json: SubscriptionSerializer.new(customer.subscriptions)
    end 
  
    def create
      subscribed = SubscriptionCustomer.new(subscription_id: params[:subscription_id], customer_id: params[:customer_id], status: 1)
  
      if subscribed.save
        render json: {success: "Customer has been subscribed."}
      else
        render json: {error: "Customer was not able to be subscribed. Please make sure info is correct."}
      end
    end
  
    def update
      subscribed = SubscriptionCustomer.find_by(subscription_id: params[:subscription_id], customer_id: params[:customer_id])
  
      if subscribed
        subscribed.update_column(:status, 0)
        render json: {success: "Customer has been unsubscribed."}
      else
        render json: {error: "Customer was not able to be unsubscribed. Please make sure info is correct."}
      end
    end
end