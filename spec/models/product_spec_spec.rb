require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    subject { described_class.new(name:"test", price_cents:1, quantity:2, category:Category.new) }

    it "will save a product with all four fields set" do
      expect(subject).to be_valid
    end

    it "will display error when name is not valid" do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.first).to eq("Name can't be blank")
    end

    it "will display error when price is not valid" do
      subject.price_cents = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.second).to eq("Price is not a number")
    end

    it "will display error when quantity is not valid" do
      subject.quantity = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.first).to eq("Quantity can't be blank")
    end

    it "will display error when quantity is not valid" do
      subject.category = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.first).to eq("Category must exist")
    end
  end
end
