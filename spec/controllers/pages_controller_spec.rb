require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #about" do
    it "get view :about" do
      get :about
    end
  end

  describe "GET #contact" do
    it "get view :contact" do
      get :contact
    end
  end

  describe "GET #projects" do
    it "get view :projects" do
      get :projects
    end
  end

end
