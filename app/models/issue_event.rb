class IssueEvent < ApplicationRecord
  belongs_to :issue

  validates :action, presence: true
  validates :sender, presence: true
  validates :issue, presence: true
end
