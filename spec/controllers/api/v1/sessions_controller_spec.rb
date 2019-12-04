require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  let!(:user) {create(:user, email: 'donia19881@wp.pl', password: '1234567')}

  describe "POST #create" do

    subject do
      @request.env["HTTP_USER_TOKEN"] = user.auth_token
      post :create, params: { user: user.attributes.merge(password: '1234567') }, format: :json
    end

    it "should success" do
      subject
      expect(response).to be_successful
    end

    context "when user is not sign_in" do

      subject do
        post :create, params: { user: user.attributes.merge(password: '') }, format: :json
      end

      it "unauthorized" do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE #destroy" do

    subject do
      @request.env["HTTP_USER_TOKEN"] = user.auth_token
      delete :destroy, params: { id: user.id }, format: :json
    end

    context "when user is an author" do

      it "should success" do
        subject
        expect(response).to be_successful
      end

      it "should delete user in db" do
        expect{ subject }.to change{user.reload.auth_token}
      end
    end

    context "when auth_token is empty" do

      subject do
        delete :destroy, params: { id: user.id }, format: :json
      end

      it "not found" do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
