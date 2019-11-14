require 'rails_helper'

describe Subscriber, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end

  it "has a valid factory" do
    subscriber = create(:subscriber)
    expect(subscriber).to be_valid
  end
end
