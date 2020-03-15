require 'rails_helper'

RSpec.describe IssueEvent, type: :model do
  let(:issue_event) { create(:issue_event) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(issue_event).to be_valid
    end

    it "is not valid without a action" do
      issue_event.action = nil
      expect(issue_event).to_not be_valid
    end

    it "is not valid without a sender" do
      issue_event.sender = nil
      expect(issue_event).to_not be_valid
    end

    it "is not valid without a issue" do
      issue_event.issue = nil
      expect(issue_event).to_not be_valid
    end
  end
end
