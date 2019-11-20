require 'rails_helper'

describe Post, type: :model do
  #let(:user) { create(:user) }
  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
