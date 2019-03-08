require 'rails_helper'
require_relative '../support/devise'

RSpec.describe ProductsController, type: :controller do
  render_views
  login_admin
  before(:each) do
    category = FactoryBot.create(:category)
  end
  before(:each) do
    @product = FactoryBot.create(:product)
  end

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  it "should get index" do
    get 'index'
    expect(response).to be_successful
  end
 
  let(:valid_attributes) {
    { title: 'Someprod',
      description: 'some description',
      category_id: 1}
  }

  let(:invalid_attributes) {
    { title: nil,
      slug: 'for-empty-product' }
  }


  describe "GET #index" do
    context "when logged in" do
      it "returns a success response" do
        get :index, params: {}
        expect(response).to be_successful
      end
    end
    context "when logged out", skip_before: true do
      it "returns a success response witout login" do
        get :index, params: {}
        expect(response).to be_successful
      end
    end
  end

  describe "GET #show" do
    context "when logged in" do
      it "returns a success response" do
        get :show, params: {id: @product.to_param}
        expect(response).to be_successful
      end
    end
    context "when logged out", skip_before: true do
      it "returns a success response" do
        get :show, params: {id: @product.to_param}
        expect(response).to be_successful
      end
    end
  end

  describe "GET #new" do
    context "when logged in" do
      it "returns a success response" do
        get :new, params: {}
        expect(response).to be_successful
      end
    end
    context "when logged out", skip_before: true do
      it "not returns a success response" do
        get :new, params: {}
        expect(response).not_to be_successful
      end
    end
  end

  describe "GET #edit" do
    context "when logged in" do
      it "returns a success response" do
        get :edit, params: {id: @product.to_param}
        expect(response).to be_successful
      end
    end
    context "when logged out", skip_before: true do
      it "not returns a success response" do
        get :edit, params: {id: @product.to_param}
        expect(response).not_to be_successful
      end
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

      it "creates a product with a custom slug" do
        valid_attributes[:slug] = 'custom_slug'
        post :create, params: {product: valid_attributes}
        get :show, params: {id: 'custom_slug'}
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      it "doesn't create a new Category" do
        expect {
          post :create, params: {product: invalid_attributes}
        }.not_to change(Product, :count)
      end
      it "render 'new' template" do
        post :create, params: {product: invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: 'Someprod2',
          description: 'some description 2',
          slug: 'another-slug'}
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

      it "updates the slug" do
        put :update, params: {id: @product.to_param, product: new_attributes}
        get :show, params: {id: 'another-slug'}
        expect(response).to be_successful
      end      
    end

    context "with invalid params" do
      it "not change product attributes" do
        put :update, params: {id: @product.to_param, product: invalid_attributes}
        expect(@product.attributes).not_to include(  {"slug" => "for-empty-product"} )
      end
      it "render 'edit' template" do
        put :update, params: {id: @product.to_param, product: invalid_attributes}
        expect(response).to render_template("edit")
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
