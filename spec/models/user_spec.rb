require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create!(first_name: 'John', last_name: 'Doe', email: 'john@email.com', password: 'password123', phone_number: '123-456-7890', address: '123 Main St', city: 'Anytown', state: 'NY', zip_code: '12345', date_of_birth: '2022-01-01')
  end
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:date_of_birth) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_length_of(:state).is_equal_to(2) }
    it { should allow_value('2022-01-01').for(:date_of_birth) }
    it { should_not allow_value('2022-13-01').for(:date_of_birth).with_message('must be in the format YYYY-MM-DD') }
  end
end
