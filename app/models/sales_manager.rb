class SalesManager < ApplicationRecord
  has_many :slots, dependent: :destroy

  VALID_LANGUAGES = [ "German", "English" ].freeze
  VALID_PRODUCTS = [ "SolarPanels", "Heatpumps" ].freeze
  VALID_CUSTOMER_RATINGS = [ "Gold", "Silver", "Bronze" ].freeze

  validates :name, presence: true
  validates :languages, presence: true, inclusion: { in: VALID_LANGUAGES }
  validates :products, presence: true, inclusion: { in: VALID_PRODUCTS }
  validates :customer_ratings, presence: true, inclusion: { in: VALID_CUSTOMER_RATINGS }
end
