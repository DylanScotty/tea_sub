require "rails_helper"

RSpec.describe Subscription, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :frequency }
  end

  describe "relationships" do
    it { should have_many :subscription_customers }
    it { should have_many(:customers).through(:subscription_customers) }
    it { should have_many :tea_subscriptions }
    it { should have_many(:teas).through(:tea_subscriptions) }
  end
end