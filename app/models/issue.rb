class Issue < ApplicationRecord
  belongs_to :repository

  has_many :events, class_name: "IssueEvent", dependent: :destroy

  validates :number, presence: true
  validates :title, presence: true
  validates :state, presence: true
  validates :github_id, presence: true
  validates :github_user_id, presence: true
  validates :github_url, presence: true
  validates :github_created_at, presence: true
  validates :github_updated_at, presence: true
  validates :repository, presence: true
end
