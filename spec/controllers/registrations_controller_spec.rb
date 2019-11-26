require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET #update" do
    let(:user) { create(:user) }
    let(:other_user) {attributes_for(:user)}

    subject do
      delete :destroy
    end

    xit "will redirect to root path" do
      sign_in(user)
      subject
      expect(flash[:notice]).to be_present
    end
  end
end
