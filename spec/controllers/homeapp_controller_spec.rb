require 'rails_helper'

RSpec.describe HomeappController, type: :controller do

  describe "GET #index" do
    let(:user) {create(:user)}

    xit "renders the other template" do
      sign_in(user)
      get :index
    end
  end
end
