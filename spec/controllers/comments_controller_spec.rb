require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "POST #create" do
    let(:post) { attributes_for(:post) }
    let(:comment) { attributes_for(:comment) }

    subject do
      post :create, comment: attributes_for(:comment), post_id: @post
    end

    it "should success create" do
      subject
      expect(response).to have_http_status(:found)
    end

    xit "should create new post in db" do
      expect{ subject }.to change(Post, :count).by(1)
    end

    it "will set notice" do
      subject
      expect(flash[:notice]).to be_present
    end

    context "when invalid" do
      let(:post_params) { attributes_for(:post, title: '') }

      xit "will render new template" do
        subject
        expect(response).to render_template(:new)
      end
    end
  end
end
