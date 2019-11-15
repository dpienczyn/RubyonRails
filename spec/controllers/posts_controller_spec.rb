require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let!(:posts) { create_list(:post, 5) }
  let(:post) { create(:post) }
  let(:user) {create(:user)}

  describe "GET #index" do
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

  describe "GET #create" do
    fit "should success create" do
      sign_in(user)
      post :create, params: { post: { author: post.author, title: post.title, description: post.description } }
      expect(response).to be_successful
    end
  end
end
