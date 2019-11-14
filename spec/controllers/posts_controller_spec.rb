require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let!(:posts) { create_list(:post, 5) }

  let(:valid_session) { {} }

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
    it 'should success and render to edit page' do
    get :show, params: { id: post.id }
    expect(response).to have_http_status(200)
    end
  end

  describe "GET #new" do
    it 'should success and render to new post' do
    get :new, params: {}, session: valid_session
    expect(response).to be_successful
    end
  end
end
