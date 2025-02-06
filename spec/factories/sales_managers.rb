FactoryBot.define do
  factory :sales_manager do
    name { Faker::Name.name }
    languages { [ 'German' ] }
    products { [ 'SolarPanels' ] }
    customer_ratings { [ 'Bronze' ] }

    trait :with_multiple_languages do
      languages { [ 'German', 'English' ] }
    end

    trait :with_multiple_products do
      products { [ 'SolarPanels', 'Heatpumps' ] }
    end

    trait :with_high_rating do
      customer_ratings { [ 'Gold', 'Silver' ] }
    end
  end
end
