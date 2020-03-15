require 'rails_helper'

RSpec.describe Repository, type: :model do
  let(:repository) { create(:repository) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(repository).to be_valid
    end

    it "is not valid without a name" do
      repository.name = nil
      expect(repository).to_not be_valid
    end

    it "is not valid without a username" do
      repository.username = nil
      expect(repository).to_not be_valid
    end
  end
end
