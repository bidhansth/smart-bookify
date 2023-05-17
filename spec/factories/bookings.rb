FactoryBot.define do
  factory :booking do
    user_name { "MyText" }
    user_email { "MyText" }
    user_contact { 1 }
    description { "MyText" }
    timeslot_id { 1 }
  end
end
