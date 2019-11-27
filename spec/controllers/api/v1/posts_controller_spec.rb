require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:user) {create(:user)}

  describe "GET #index " do
    let(:post) { create(:post) }

    it "returns http status success" do
      expect(response).to have_http_status(:success)
    end

    it "should success" do
      get :index, format: :json
      expect(response).to be_success
    end
  end

  describe "GET #show" do

    let(:post) { create(:post) }

    it 'should ok response' do
      get :show, params: { id: post.id }, format: :json
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #new" do

    it 'should success' do
      sign_in(user)
      get :new, format: :json
      expect(response).to be_success
    end

    it 'should assign new post' do
      sign_in(user)
      get :new, format: :json
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "POST #create" do
    let(:user) {create(:user)}
    let(:post_params) { attributes_for(:post) }

    subject do
      sign_in(user)
      post :create, params: { post: post_params }
    end

    it "returns http status :created" do
      subject
      expect(response).to have_http_status(:created)
    end

    context "when invalid" do
      let(:post_params) { attributes_for(:post, title: '') }

      it "when title is empty" do
        sign_in(user)
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "send email to subscriber" do
      let(:subscriber) { create(:subscriber) }

      subject do
        sign_in(user)
        post :create, params: { post: post_params }
      end

      it 'send email' do
        expect { SubscriberMailer.new_post(subscriber, subject)}
        .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end

  describe "PUT #update" do
    let(:post) { create(:post, user: user) }
    let(:post_params) { attributes_for(:post, title: 'test') }

    subject do
      put :update, params: { id: post.id, post: post_params }, format: :json
    end

    it "should success" do
      sign_in(user)
      subject
      expect(response).to be_success
    end

    context "when invalid" do
      let(:post_params) { attributes_for(:post, title: '') }

      it "when title is empty" do
        sign_in(user)
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:post) { create(:post, user: user) }

    subject do
      delete :destroy, params: { id: post.id }, format: :json
    end

    it "should delete post in db" do
      sign_in(user)
      expect{ subject }.to change(Post, :count).by(-1)
    end
  end
end
