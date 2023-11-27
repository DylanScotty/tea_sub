require "rails_helper"

RSpec.describe "Subscription Request" do
  before(:each) do
    @customer_1 = Customer.create(
      first_name: "Dylan",
      last_name: "Timmons",
      email: "dt@gmail.com",
      address: "1234 Fake Address"
    )

    @tea_1 = Tea.create(
      title: "Green",
      description: "Let it heal the body",
      temperature: "115 F",
      brew_time: "4 minutes"
    )

    @tea_2 = Tea.create(
      title: "Black",
      description: "Great evening brew",
      temperature: "115 F",
      brew_time: "6 minutes"
    )

    @tea_3 = Tea.create(
      title: "Peppermint",
      description: "Great for the holidays",
      temperature: "101 F",
      brew_time: "6 minutes"
    )

    @tea_4 = Tea.create(
      title: "Earlgray",
      description: "The best of english teas",
      temperature: "105 F",
      brew_time: "9 minutes"
    )

    @subscription = Subscription.create(
      title: "Starter Pack",
      price: 15.00,
      frequency: "3 weeks"
    )

    @subscription_2 = Subscription.create(
      title: "Holiday Pack",
      price: 25.00,
      frequency: "1 month"
    )

    TeaSubscription.create(subscription_id: @subscription.id, tea_id: @tea_1.id)
    TeaSubscription.create(subscription_id: @subscription.id, tea_id: @tea_2.id)

    TeaSubscription.create(subscription_id: @subscription_2.id, tea_id: @tea_3.id)
    TeaSubscription.create(subscription_id: @subscription_2.id, tea_id: @tea_4.id)
  end

  it "sends message showing that a customer has subscribed to a tea subscription" do
    post "/api/v1/customers/#{@customer_1.id}/subscriptions/#{@subscription.id}"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to eq({success: "Customer has been subscribed."})

    expect(@customer_1.subscriptions.count).to eq(1)
    expect(@customer_1.subscriptions.first).to be_a(Subscription)
    expect(@customer_1.subscriptions.first.title).to eq("Starter Pack")
    expect(@customer_1.subscriptions.first.price).to eq(15.0)
    expect(@customer_1.subscriptions.first.frequency).to eq("3 weeks")
    expect(@customer_1.subscription_customers.first.status).to eq("active")
  end

  it "sends message showing that customer has been unsubscribed from a tea subscription" do
    post "/api/v1/customers/#{@customer_1.id}/subscriptions/#{@subscription.id}"

    patch "/api/v1/customers/#{@customer_1.id}/subscriptions/#{@subscription.id}"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to eq({success: "Customer has been unsubscribed."})

    expect(@customer_1.subscriptions.count).to eq(1)
    expect(@customer_1.subscriptions.first).to be_a(Subscription)
    expect(@customer_1.subscriptions.first.title).to eq("Starter Pack")
    expect(@customer_1.subscriptions.first.price).to eq(15.0)
    expect(@customer_1.subscriptions.first.frequency).to eq("3 weeks")
    expect(@customer_1.subscription_customers.first.status).to eq("cancelled")
  end

  it "should return all of a customer's subscriptions" do
    post "/api/v1/customers/#{@customer_1.id}/subscriptions/#{@subscription.id}"
    post "/api/v1/customers/#{@customer_1.id}/subscriptions/#{@subscription_2.id}"

    get "/api/v1/customers/#{@customer_1.id}/subscriptions"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:data)
    expect(json[:data]).to be_an(Array)
    expect(json[:data].count).to eq(2)

    json[:data].each do |subscription|
      expect(subscription).to have_key(:id)
      expect(subscription[:id]).to be_a(String)

      expect(subscription).to have_key(:type)
      expect(subscription[:type]).to eq("subscription")

      expect(subscription).to have_key(:attributes)
      expect(subscription[:attributes]).to be_a(Hash)

      expect(subscription[:attributes]).to have_key(:title)
      expect(subscription[:attributes][:title]).to be_a(String)

      expect(subscription[:attributes]).to have_key(:price)
      expect(subscription[:attributes][:price]).to be_a(Float)

      expect(subscription[:attributes]).to have_key(:frequency)
      expect(subscription[:attributes][:frequency]).to be_a(String)
    end
  end
end