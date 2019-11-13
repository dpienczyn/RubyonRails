require 'rails_helper'

describe Subscriber, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end
  
  xit "has a valid factory" do
    user = create(:user)
    expect(user).to be_valid
  end
end
