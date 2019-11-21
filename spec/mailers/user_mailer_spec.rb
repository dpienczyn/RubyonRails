require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  let(:user) {create(:user)}

  describe "notify" do
    let(:mail) { UserMailer.welcome_email(user) }

    it "check subject e-mail" do
      expect(mail.subject).to eq("Witamy na naszej stronie")
    end

    it "check address e-mail" do
      expect(mail.from).to eq(["pienczyn.d@gmail.com"])
    end
  end
end
