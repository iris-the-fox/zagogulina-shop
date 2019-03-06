require 'rails_helper'
require_relative '../support/devise'

RSpec.describe ProductsController, type: :controller do
  login_admin
  before(:each) do
    category = FactoryBot.create(:category)
  end
  before(:each) do
    @product = FactoryBot.create(:product)
  end

  it "should have a current_user" do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect(subject.current_user).to_not eq(nil)
  end

  it "should get index" do
    # Note, rails 3.x scaffolding may add lines like get :index, {}, valid_session
    # the valid_session overrides the devise login. Remove the valid_session from your specs
    get 'index'
    expect(response).to be_successful
  end
  # This should return the minimal set of attributes required to create a valid
  # Category. As you add validations to Category, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { title: 'Someprod',
      description: 'some description',
      category_id: 1}
  }

  let(:invalid_attributes) {
    { slug: 'for-empty-product' }
  }


  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
    it "returns a success response witout login", skip_before: true do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: {id: @product.to_param}
      expect(response).to be_successful
    end
    it "returns a success response witout login", skip_before: true do
      get :show, params: {id: @product.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
    it "not returns a success response witout login", skip_before: true do
      get :new, params: {}
      expect(response).not_to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: {id: @product.to_param}
      expect(response).to be_successful
    end
    it "not returns a success response witout login", skip_before: true do
      get :edit, params: {id: @product.to_param}
      expect(response).not_to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, params: {product: valid_attributes}
        }.to change(Product, :count).by(1)
      end

      it "redirects to the created product" do
        post :create, params: {product: valid_attributes}
        expect(response).to redirect_to(Product.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {product: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: 'Someprod2',
          description: 'some description 2'}
      }

      it "updates the requested product" do
        put :update, params: {id: @product.to_param, product: new_attributes}
        @product.reload
        expect(@product.attributes).to include(  {"title" => "Someprod2", "description" => "some description 2"} )
      end

      it "redirects to the product" do
        put :update, params: {id: @product.to_param, product: new_attributes, slug: new_attributes{:slug}}
        @product.reload
        expect(response).to redirect_to(@product)
      end
    end

    context "with invalid params" do
      it " not returns a success response" do
        put :update, params: {id: @product.to_param, product: invalid_attributes}
        expect(response.body).to include("redirected")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      expect {
        delete :destroy, params: {id: @product.to_param}
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      delete :destroy, params: {id: @product.to_param}
      expect(response).to redirect_to(products_url)
    end
  end

end
