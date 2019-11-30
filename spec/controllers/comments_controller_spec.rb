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
      expect{ subject }.to change(Comment, :count).by(1)
    end

    context "when invalid" do
      let(:comment) { attributes_for(:comment, comment:'', body:'') }

      subject do
        post :create, params: { comment: attributes_for(:comment), post_id: article.id }
      end

      it "will render new template" do
      
        expect(subject).to redirect_to post_path
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:comment) { create(:comment) }

    subject do
      delete :destroy, params: { id: comment.id, post_id: comment.post.id }
    end

    it "will set notice" do
      subject
      expect(flash[:notice]).to be_present
    end

    it "should delete comment in db" do
      expect{ subject }.to change(Comment, :count).by(-1)
    end
  end
end
