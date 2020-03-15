FactoryBot.define do
  factory :repository do
    name { "finhub" }
    username { "dfingolo" }
    token { SecureRandom.uuid }
  end
end
