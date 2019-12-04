require 'rails_helper'

describe Comment, type: :model do
  #let(:user) { create(:user) }
  context 'associations' do
  	it { is_expected.to belong_to(:post) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:comment) }
    it { is_expected.to validate_presence_of(:body) }
  end
end
