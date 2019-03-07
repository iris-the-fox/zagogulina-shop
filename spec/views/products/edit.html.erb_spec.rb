require 'rails_helper'

RSpec.describe "products/edit", type: :view do
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

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input[name=?]", "product[title]"

      assert_select "textarea[name=?]", "product[description]"

      assert_select "input[name=?]", "product[category_id]"
    end
  end
end
