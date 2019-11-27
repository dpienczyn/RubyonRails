require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  describe "POST #create" do
    let(:any_user) {attributes_for(:user, email: 'donia19881@wp.pl', password: '1234567')}
    let(:user) {create(:user)}

    subject do
      post :create, params: { user: any_user }, format: :json
      sign_in(user)
    end

    it "should success" do
      subject
      user.reload
      expect(response).to be_success
    end

    context "when user is not sign_in" do

      subject do
        post :create, params: { user: any_user }, format: :json
      end

      it "unauthorized" do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
