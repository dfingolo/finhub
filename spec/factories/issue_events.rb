FactoryBot.define do
  factory :issue_event do
    action { "opened" }
    sender { "dfingolo" }
    issue
  end
end
