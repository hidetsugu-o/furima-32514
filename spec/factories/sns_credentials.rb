FactoryBot.define do
  factory :sns_credential do
    provider { "facebook" }
    uid { 0000000000000000 }
    
    association :user
  end
end
