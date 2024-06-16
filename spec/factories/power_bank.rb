FactoryBot.define do
  factory :power_bank do
    sequence(:serial_number) { |n| "PB#{n}" }
    station { nil }
    warehouse { nil }
    user { nil }
  end
end