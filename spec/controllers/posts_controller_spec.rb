require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let!(:posts) { create_list(:post, 5) }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    fit "returns a search posts" do
      post = create(:post, title: "graphic")
      get :index, params: { search: "graphi" }
      expect(assigns(:posts)).to eq [post]
    end
  end
end
