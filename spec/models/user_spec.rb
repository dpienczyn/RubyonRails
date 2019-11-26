require 'rails_helper'

describe User, type: :model do
  #let(:user) { create(:user) }
  context 'associations' do
  	it { is_expected.to have_many(:posts) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  it "has a valid factory" do
    user = create(:user)
    expect(user).to be_valid
  end
end
