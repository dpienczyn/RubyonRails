require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #about" do

    it "renders the other template" do
      get :about
    end
  end
end
