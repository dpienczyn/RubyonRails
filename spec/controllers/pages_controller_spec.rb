require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #about" do
    it "renders the other template" do
      get :about
    end
  end

  describe "GET #contact" do
    it "renders the other template" do
      get :contact
    end
  end

  describe "GET #projects" do
    it "renders the other template" do
      get :projects
    end
  end

end
