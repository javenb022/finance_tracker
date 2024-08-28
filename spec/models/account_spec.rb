require 'rails_helper'

RSpec.describe Account do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:account_type) }
    it { is_expected.to validate_presence_of(:balance) }
    it { is_expected.to validate_presence_of(:currency) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to define_enum_for(:account_type).with_values(checking: 0, savings: 1, credit: 2) }
  end
end
