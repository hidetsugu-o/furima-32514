FactoryBot.define do
  factory :user do
    nickname {Faker::Name.initials(number: 2)}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    last_name {"てすと"}
    first_name {"太郎"}
    last_kana {"テスト"}
    first_kana {"タロウ"}
    birthday {Faker::Date.between(from: '1991-09-23', to: '2020-09-25')}
  end
end