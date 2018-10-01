require "rails_helper"

RSpec.describe ImportError, type: :mailer do
  describe "import_error_messages" do
    let(:mail) { ImportError.import_error_messages }

    it "renders the headers" do
      expect(mail.subject).to eq("Import error messages")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
