require 'rails_helper'

RSpec.describe Issue, type: :model do
  let(:issue) { create(:issue) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(issue).to be_valid
    end

    it "is not valid without a action" do
      issue.number = nil
      expect(issue).to_not be_valid
    end

    it "is not valid without a title" do
      issue.title = nil
      expect(issue).to_not be_valid
    end

    it "is not valid without a state" do
      issue.state = nil
      expect(issue).to_not be_valid
    end

    it "is not valid without a github_id" do
      issue.github_id = nil
      expect(issue).to_not be_valid
    end

    it "is not valid without a github_user_id" do
      issue.github_user_id = nil
      expect(issue).to_not be_valid
    end

    it "is not valid without a github_url" do
      issue.github_url = nil
      expect(issue).to_not be_valid
    end

    it "is not valid without a github_created_at" do
      issue.github_created_at = nil
      expect(issue).to_not be_valid
    end

    it "is not valid without a github_updated_at" do
      issue.github_updated_at = nil
      expect(issue).to_not be_valid
    end

    it "is not valid without a repository" do
      issue.repository = nil
      expect(issue).to_not be_valid
    end
  end
end
