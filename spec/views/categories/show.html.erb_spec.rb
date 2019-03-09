require 'rails_helper'


RSpec.describe "categories/show", type: :view do
  before(:each) do 
    @category = FactoryBot.create(:category)
  end
  before(:each) do |example|
    unless example.metadata[:skip_before]
      @product = FactoryBot.create(:product)
    end
  end



  it "renders category name" do
    render
    expect(rendered).to match(/sometitle/)
  end

  context "if products exists" do
    it "renders products names" do
      assign(:products, Product.where(category_id: [@category.subtree_ids]).exists? ? Product.where(category_id: [@category.subtree_ids]) : nil)
      render
      expect(rendered).to match(/someprod/)
    end
  end
  context "if products didn't exists" do
    it "renders 'There is no products'", skip_before: true do
  	  assign(:products, Product.where(category_id: [@category.subtree_ids]).exists? ? Product.where(category_id: [@category.subtree_ids]) : nil)
      render
      expect(rendered).to match(/There is no products/)
    end
  end

  describe "Administration" do
    context "if logged in" do
    	it "renders Edit | Destroy" do
    	   @request.env["devise.mapping"] = Devise.mappings[:admin]
          sign_in FactoryBot.create(:admin)
    	  render
        expect(rendered).to match(/Edit/)
        expect(rendered).to match(/Destroy/)	
      end
    end
  
    context "if logged put" do
    	it "not renders Edit | Destroy" do
    	  render
        expect(rendered).not_to match(/Edit/)
        expect(rendered).not_to match(/Destroy/)	
      end
    end
  end


end
