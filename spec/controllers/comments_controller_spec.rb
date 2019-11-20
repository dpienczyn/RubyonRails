require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let!(:comments) { create_list(:comment, 5) }

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
  end

  describe "DELETE #destroy" do
    let(:article) { create(:post) }
    let!(:comment) { create(:comment) }

    subject do
      delete :destroy, params: { id: comment.id, post_id: article.id }
    end

      xit "will set notice" do
        subject
        expect(flash[:notice]).to be_present
      end

      xit "will redirect to posts_url" do
        subject
        expect(response).to redirect_to(posts_url)
      end

      xit "should delete post in db" do
        expect{ subject }.to change(Post, :count).by(-1)
      end
    end
end