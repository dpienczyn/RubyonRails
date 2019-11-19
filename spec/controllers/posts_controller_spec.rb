require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let!(:posts) { create_list(:post, 5) }
  let(:user) {create(:user)}
  let(:subscriber) {create(:subscriber)}

  describe "GET #index" do

    let(:post) { create(:post) }

    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "returns a search posts" do
      post = create(:post, title: "graphic")
      get :index, params: { search: "graphi" }
      expect(assigns(:posts)).to eq [post]
    end
  end

  describe "GET #show" do

    let(:post) { create(:post) }

    it 'should success response' do
      get :show, params: { id: post.id }
      expect(response).to be_successful
    end

    it 'should render show page' do
      get :show, params: { id: post.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do

    it 'requires authentication' do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'should success' do
      sign_in(user)
      get :new
      expect(response).to be_successful
    end

    it 'should render new page' do
      sign_in(user)
      get :new
      expect(response).to render_template(:new)
    end

    it 'should assign new post' do
      sign_in(user)
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "POST #create" do
    let(:post_params) { attributes_for(:post) }

    subject do
      sign_in(user)
      post :create, params: { post: post_params }
    end

    it "requires authentication" do
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should success create" do
      subject
      expect(response).to have_http_status(:found)
    end

    it "should create new post in db" do
      expect{ subject }.to change(Post, :count).by(1)
    end

    it "will set notice" do
      subject
      expect(flash[:notice]).to be_present
    end

    context "when invalid" do
      let(:post_params) { attributes_for(:post, title: '') }

      it "will render new template" do
        subject
        expect(response).to render_template(:new)
      end
    end
  end


  describe "PUT #update" do
    let(:other_user) { create(:user) }
    let(:post) { create(:post, user: user) }
    let(:post_params) { attributes_for(:post, title: 'test') }

    subject do
      put :update, params: { id: post.id, post: post_params }
    end

    it "will redirect to root path" do
      sign_in(user)
      subject
      expect(response).to redirect_to post_path
    end

    context "when user is an author" do

      it "updates requested post" do
        sign_in(user)
        subject
        post.reload
        expect(post.title).to eq('test')
       end
     end

    context "when user is not an author" do

      it "not updates requested post" do
        sign_in(other_user)
        subject
        expect(response).to_not be_successful
      end
    end

    context "when invalid params" do
      let(:post_params) { attributes_for(:post, title: '') }

      it "will render edit template" do
        sign_in(user)
        subject
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:other_user) { create(:user) }
    let(:post) { create(:post, user: user) }
    let(:post_params) { attributes_for(:post) }

    subject do
      delete :destroy, params: { id: post.id, post: post_params }
    end

    xit "requires authentication" do
      delete :destroy
      expect(response).to redirect_to(new_user_session_path)
    end

    context "when user is an author" do

      it "will set notice" do
        sign_in(user)
        subject
        expect(flash[:notice]).to be_present
      end

      it "will redirect to posts_url" do
        sign_in(user)
        subject
        expect(response).to redirect_to(posts_url)
      end

      it "should delete post in db" do
        sign_in(user)
        subject
        expect{ subject }.to change{ Post.count }.by(0)
      end
    end

    context "when user is not an author" do

      it "not delete requested post" do
        sign_in(other_user)
        subject
        expect(response).to_not be_successful
      end
    end
  end
end
