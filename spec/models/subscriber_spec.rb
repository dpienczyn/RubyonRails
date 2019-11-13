require 'rails_helper'

describe Subscriber, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }

  xit "has a valid factory" do
    user = create(:user)
    expect(user).to be_valid
  end
end
