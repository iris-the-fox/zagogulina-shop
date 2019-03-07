require 'rails_helper'
require_relative '../../support/devise'

RSpec.describe "products/show", type: :view do
  login_admin
  before(:each) do
    category = FactoryBot.create(:category)
  end
  before(:each) do
    @product = FactoryBot.create(:product,
      :title => "MyString",
      :description => "MyText",
      :category_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
