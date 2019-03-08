require 'rails_helper'


RSpec.describe Category, type: :model do

  describe "Validations" do 
    it "is valid with valid attributes" do
      expect(FactoryBot.create(:category)).to be_valid
    end
    it "is not valid without a title" do
    	expect(FactoryBot.build(:category, title: nil)).to_not be_valid
    end
  end

  describe "Associations" do
    it { is_expected.to have_many(:products) }
  end

  describe "Slugging" do
    it "creates a slug from title" do
    	expect(FactoryBot.create(:category).slug).to eq("sometitle")
    end
  
    it "takes the provided slug if it is given" do
    	expect(FactoryBot.create(:category, slug: "another-slug").slug).to eq("another-slug")
    end
  end

  describe "Ancestry" do
     it "should create the child" do
      category=FactoryBot.create(:category)
      child_category = FactoryBot.create(:child_category)
      expect(child_category.parent.title).to eq("sometitle")
      expect(category.children).to include child_category
    end
  end

end
