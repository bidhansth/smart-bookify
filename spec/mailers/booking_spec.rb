require "rails_helper"

RSpec.describe BookingMailer, type: :mailer do
  describe "booking_confirm" do
    let(:mail) { BookingMailer.booking_confirm }

    it "renders the headers" do
      expect(mail.subject).to eq("Booking confirm")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
