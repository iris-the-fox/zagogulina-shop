require 'rails_helper'


RSpec.describe Product, type: :model do
  
  before(:each) do
      category = FactoryBot.create(:category)
  end

  describe "Validations" do 
    it "is valid with valid attributes" do
      expect(FactoryBot.create(:product)).to be_valid
    end
    it "is not valid without a title" do
    	expect(FactoryBot.build(:product, title: nil)).to_not be_valid
    end
  end

  describe "Associations" do
    it { is_expected.to belong_to(:category) }
  end

  describe "Slugging" do
    it "creates a slug from title" do
    	expect(FactoryBot.create(:product).slug).to eq("someprod")
    end
  
    it "takes the provided slug if it is given" do
    	expect(FactoryBot.create(:product, slug: "another-slug").slug).to eq("another-slug")
    end
  end
  
end
