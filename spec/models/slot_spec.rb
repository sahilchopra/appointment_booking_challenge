require 'rails_helper'

RSpec.describe Slot, type: :model do
  # Associations
  it { should belong_to(:sales_manager) }

  # Validations
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_inclusion_of(:booked).in_array([ true, false ]) }

  # Custom validations
  it 'validates start_date should be before end_date' do
    slot = build(:slot, start_date: '2024-05-03T12:00Z', end_date: '2024-05-03T11:00Z')
    expect(slot).not_to be_valid
    expect(slot.errors[:end_date]).to include("must be after the start date")
  end

  # Factory validations
  describe 'FactoryBot' do
    it 'has a valid factory' do
      slot = build(:slot)
      expect(slot).to be_valid
    end
  end
end
