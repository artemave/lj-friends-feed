FactoryGirl.define do
  sequence(:counter) {|n| n }

  factory :entry do
    author { Faker::Name.first_name.downcase }
    link { "http://#{author}.livejournal.com/#{generate :counter}.html" }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    pub_date { "Mon, 14 May 2012 21:#{generate :counter}:16 GMT" }
  end
end
