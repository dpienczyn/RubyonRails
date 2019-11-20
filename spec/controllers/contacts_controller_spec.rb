require 'rails_helper'

RSpec.describe ContactController, type: :controller do

  describe "GET #index" do

    it "renders the other template" do
      get :index
    end
  end
end
