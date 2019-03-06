require 'rails_helper'


RSpec.describe Product, type: :model do
  before(:each) do
      category = FactoryBot.create(:category)
  end
  
  it "is valid with valid attributes" do
    expect(FactoryBot.create(:product)).to be_valid
  end
  it "is not valid without a title" do
  	expect(FactoryBot.build(:product, title: nil)).to_not be_valid
  end
end
