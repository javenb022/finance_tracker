require "rails_helper"

RSpec.describe Transaction do
  describe "validations" do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:transaction_type) }
    it { is_expected.to validate_presence_of(:transaction_date) }
    it { is_expected.to belong_to(:account) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to define_enum_for(:transaction_type).with_values(%i[income expense transfer]) }
  end
end
