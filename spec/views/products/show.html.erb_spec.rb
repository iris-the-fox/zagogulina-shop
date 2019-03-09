require 'rails_helper'


RSpec.describe "products/show", type: :view do
  before(:each) do 
    @category = FactoryBot.create(:category)
    @product = FactoryBot.create(:product)
  end



  it "renders product name" do
    render
    expect(rendered).to match(/someprod/)
  end

  it "renders parent category name" do
    render
    expect(rendered).to match(/sometitle/)
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
