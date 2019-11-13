require 'rails_helper'

describe Comment, type: :model do
  #let(:user) { create(:user) }
  context 'associations' do
  	it { is_expected.to belong_to(:post) }
  end
end
