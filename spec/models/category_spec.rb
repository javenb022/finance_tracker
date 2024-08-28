require 'rails_helper'

RSpec.describe Category do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:category_type) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:category_type).with_values(%i[other expense income transfer]) }
  end
end
