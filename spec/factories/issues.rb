FactoryBot.define do
  factory :issue do
    sequence(:number) { |n| n }
    title { "Issue #{number}" }
    state { "opened" }
    locked { false }
    github_id { number }
    github_user_id { 1 }
    github_url { "https://api.github.com/repos/dfingolo/finhub/issues/#{number}" }
    github_created_at { DateTime.parse("2020-03-14 11:59:56") }
    github_updated_at { DateTime.parse("2020-03-14 11:59:56") }
    repository
  end
end
