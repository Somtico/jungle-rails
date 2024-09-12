require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # Setup a valid category for the product
    let(:category) { Category.create(name: 'Electronics') }

    it "saves successfully with all fields set" do
      product = Product.new(name: 'Phone', price: 1000, quantity: 5, category: category)
      expect(product).to be_valid
    end

    it 'validates presence of name' do
      product = Product.new(name: nil, price: 1000, quantity: 5, category: category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates presence of price' do
      product = Product.new(name: 'Phone', price_cents: nil, quantity: 5, category: category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'validates presence of quantity' do
      product = Product.new(name: 'Phone', price: 1000, quantity: nil, category: category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates presence of category' do
      product = Product.new(name: 'Phone', price: 1000, quantity: 5, category: nil)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
