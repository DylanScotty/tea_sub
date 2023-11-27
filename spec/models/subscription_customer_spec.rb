require "rails_helper"

RSpec.describe SubscriptionCustomer, type: :model do
  describe "relationships" do
    it { should belong_to :subscription }
    it { should belong_to :customer }
  end
end