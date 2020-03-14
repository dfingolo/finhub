class Repository < ApplicationRecord
  has_many :issues

  validates :name, presence: true
  validates :username, presence: true
end
