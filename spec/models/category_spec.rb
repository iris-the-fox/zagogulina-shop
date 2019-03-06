require 'rails_helper'
require_relative '../support/devise'

RSpec.describe Category, type: :model do
  it "is valid with valid attributes" do
    expect(FactoryBot.create(:category)).to be_valid
  end
  it "is not valid without a title" do
  	expect(FactoryBot.build(:category, title: nil)).to_not be_valid
  end
end
