require "rails_helper"

RSpec.describe SubscribersNotifyService, type: :mailer do
  let(:subscriber) { create(:subscriber) }
  let(:post) { create(:post) }

  describe "notify" do
    let(:mail) { SubscribersNotifyService.new_post(subscriber, post) }

    it "check address e-mail" do
      expect(mail.from).to eq(["pienczyn.d@gmail.com"])
    end

    it "check subject e-mail" do
      expect(mail.subject).to eq("Nowy Post")
    end
  end
end
