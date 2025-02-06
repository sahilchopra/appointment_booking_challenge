require 'rails_helper'

RSpec.describe SalesManager, type: :model do
  # Associations
  it { should have_many(:slots).dependent(:destroy) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:languages) }
  it { should validate_presence_of(:products) }
  it { should validate_presence_of(:customer_ratings) }

  # Factory validations
  describe 'FactoryBot' do
    it 'has a valid factory' do
      sales_manager = build(:sales_manager)
      expect(sales_manager).to be_valid
    end
  end

  # Custom validation cases
  context 'when languages, products, and ratings are invalid' do
    let(:sales_manager) { build(:sales_manager, languages: [ 'Spanish' ], products: [ 'AirConditioner' ], customer_ratings: [ 'Platinum' ]) }

    it 'is not valid' do
      expect(sales_manager).not_to be_valid
    end
  end
end
