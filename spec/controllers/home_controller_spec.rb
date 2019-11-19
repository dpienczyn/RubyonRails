require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  let(:user) {create(:user)}

  describe "GET #index" do

    xit "renders the other template" do
      sign_in(user)
      expect(response).to redirect_to homeapp_index_path
    end
  end
end
