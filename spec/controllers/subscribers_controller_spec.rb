require 'rails_helper'

RSpec.describe SubscribersController, type: :controller do

  let!(:subscribers) { create_list(:subscriber, 5) }

  describe "POST #create" do

    let(:subscriber_params) { attributes_for(:subscriber) }

    subject do
      post :create, params: { subscriber: subscriber_params }
    end

    it "should success create" do
      subject
      expect(response).to have_http_status(:found)
    end

    it "should create new subscriber in db" do
      expect{ subject }.to change(Subscriber, :count).by(1)
    end

    it "will set notice" do
      subject
      expect(flash[:notice]).to be_present
    end

    context "when invalid params" do
      let(:subscriber_params) { attributes_for(:subscriber, name: '', email: '') }

      it "have no value" do
        subject
        expect(response).to redirect_to root_path
      end
    end
  end
end
