require "rails_helper"

RSpec.describe TeaSubscription, type: :model do
  describe "reltionships" do
    it { should belong_to :subscription }
    it { should belong_to :tea }
  end
end