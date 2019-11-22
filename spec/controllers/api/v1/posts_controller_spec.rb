require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  describe "GET #index " do
    let(:post) { create(:post) }

    it "returns a successful 200 response" do
      get :index, format: :json
      expect(response).to be_success
    end
  end
end
