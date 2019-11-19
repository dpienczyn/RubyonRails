require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  ##let!(:comments) { create_list(:comment, 5) }

  describe "POST #create" do
    let(:article) { create(:post) }
    let(:comment) { attributes_for(:comment) }

    subject do
      post :create, params: { comment: attributes_for(:comment), post_id: article.id }
    end

    it "should success create" do
      subject
      expect(response).to have_http_status(:found)
    end

    it "should create new comment in db" do
      puts Comment.count
      expect{ subject }.to change(Comment, :count).by(1)
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
