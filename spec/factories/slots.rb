FactoryBot.define do
  factory :slot do
    association :sales_manager
    start_date { Time.zone.now + 1.day }
    end_date { start_date + 1.hour }
    booked { false }

    trait :booked do
      booked { true }
    end

    trait :in_future do
      start_date { Time.zone.now + 7.days }
      end_date { start_date + 1.hour }
    end

    trait :in_past do
      start_date { Time.zone.now - 7.days }
      end_date { start_date + 1.hour }
    end
  end
end
