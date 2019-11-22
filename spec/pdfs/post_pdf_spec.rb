require "rails_helper"

RSpec.describe PostPdf, :type => :pdf do
  let(:post) { create(:post) }

	describe "pdf" do
    let(:pdf) { PostPdf.initialize(post) }

    xit "check title post" do
      expect(pdf.text).to eq(["Tytuł: #{@post.title}"])
    end
  end
end
