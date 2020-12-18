FactoryBot.define do
  factory :buyer_shipping_address do
    user_id { Faker::Number.within(range: 1..100) }
    item_id { Faker::Number.within(range: 1..100) }
    postal_code { Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s }
    prefecture_id { Faker::Number.within(range: 2..48) }
    municipality { '横浜市緑区' }
    address { '青山1-1-1' }
    building { '柳ビル103' }
    phone_number { Faker::Number.number(digits: 11).to_s }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
