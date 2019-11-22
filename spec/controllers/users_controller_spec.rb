require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) {create(:user)}

  describe "GET #update" do

    subject do
      sign_in(user)
      get :edit
    end

    xit "will redirect to root path" do
      subject
      expect(response).to render_template :edit
    end
  end
end
