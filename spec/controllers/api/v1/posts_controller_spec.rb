require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  let(:user) {create(:user, email: 'donia19881@wp.pl', password: '1234567')}

  describe "GET #index" do
    let(:post) { create(:post) }

    it "returns http status success" do
      expect(response).to have_http_status(:success)
    end

    it "should success" do
      get :index, format: :json
      expect(response).to be_successful
    end
  end

  describe "GET #show" do

    let(:post) { create(:post) }

    it "should ok response" do
      get :show, params: { id: post.id }, format: :json
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #new" do

    subject do
      @request.env["HTTP_USER_TOKEN"] = user.auth_token
      get :new, params: { user: user.attributes.merge(password: '1234567') }, format: :json
    end

    it "should success" do
      subject
      expect(response).to be_successful
    end

    it "should assign new post" do
      subject
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "POST #create" do
    let(:post_params) { attributes_for(:post) }

    subject do
      @request.env["HTTP_USER_TOKEN"] = user.auth_token
      post :create, params: { post: post_params, user: user.attributes.merge(password: '1234567') }, format: :json
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

      it 'send email' do
        expect { SubscribersNotifyService.new_post(subscriber, subject)}
        .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end

  describe "PUT #update" do
    let(:post) { create(:post, user: user) }
    let(:post_params) { attributes_for(:post, title: 'test') }

    subject do
      @request.env["HTTP_USER_TOKEN"] = user.auth_token
      put :update, params: { id: post.id, post: post_params, user: user.attributes.merge(password: '1234567') }, format: :json
    end

    it "should success" do
      subject
      expect(response).to be_successful
    end

    context "when invalid" do
      let(:post_params) { attributes_for(:post, title: '') }

      it "when title is empty" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:post) { create(:post, user: user) }

    subject do
      @request.env["HTTP_USER_TOKEN"] = user.auth_token
      delete :destroy, params: { id: post.id, user: user.attributes.merge(password: '1234567') }, format: :json
    end

    it "should delete post in db" do
      expect{ subject }.to change(Post, :count).by(-1)
    end
  end
end
