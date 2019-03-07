require 'rails_helper'
require_relative '../support/devise'

RSpec.describe CategoriesController, type: :controller do
  render_views
  login_admin
  before(:each) do
    @category = FactoryBot.create(:category)
  end
  describe 'Login' do
    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end
  end

  let(:valid_attributes) {
    { title: 'Somecat'}
  }

  let(:invalid_attributes) {
    { title: nil,
      slug: 'for-empty-category' }
  }
  


  describe "GET #index" do
    context "when logged in" do
      it "returns a success response" do
        get :index, params: {}
        expect(response).to be_successful
      end
    end
    context "when logged out", skip_before: true do
      it "returns a success response" do
        get :index, params: {}
        expect(response).to be_successful
      end
    end
  end

  describe "GET #show" do
    context "when logged in" do
      it "returns a success response" do
        get :show, params: {id: @category.to_param}
        expect(response).to be_successful
      end
    end
    context "when logged out", skip_before: true do
      it "returns a success response" do
        get :show, params: {id: @category.to_param}
        expect(response).to be_successful
      end
    end
  end

  describe "GET #manage" do
    context "when logged in" do
      it "returns a success response" do
        get :manage
        expect(response).to be_successful
      end
    end
    context "when logged out", skip_before: true do
      it "not returns a success response" do
        get :manage
        expect(response).not_to be_successful
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
        get :edit, params: {id: @category.to_param}
        expect(response).to be_successful
      end
    end
    context "when logged out", skip_before: true do
      it "not returns a success response" do
        get :edit, params: {id: @category.to_param}
        expect(response).not_to be_successful
      end
    end
  end


  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, params: {category: valid_attributes}
        }.to change(Category, :count).by(1)
      end

      it "redirects to the created category" do
        post :create, params: {category: valid_attributes}
        expect(response).to redirect_to(Category.last)
      end
    end

    context "with invalid params" do
      it "doesn't create a new Product" do
        expect {
          post :create, params: {category: invalid_attributes}
        }.not_to change(Category, :count)
      end
      it "render 'new' template" do
        post :create, params: {category: invalid_attributes}
        expect(response).to render_template("new")
      end
    end

  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: 'Somecat2', slug: 'another-slug'}
      }

      it "updates the requested category" do
        put :update, params: {id: @category.to_param, category: new_attributes}
        @category.reload
        expect(@category.attributes).to include(  {"title" => "Somecat2", "slug" => 'another-slug'} )
      end

      it "redirects to the category" do
        put :update, params: {id: @category.to_param, category: new_attributes, slug: new_attributes{:slug}}
        @category.reload
        expect(response).to redirect_to(@category)
      end
    end

    context "with invalid params" do
      it "not change category attributes" do
        put :update, params: {id: @category.to_param, category: invalid_attributes}
        expect(@category.attributes).not_to include(  {"slug" => "for-empty-category"} )
      end
      it "render 'edit' template" do
        put :update, params: {id: @category.to_param, category: invalid_attributes}
        expect(response).to render_template("edit")
       end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested category" do
      expect {
        delete :destroy, params: {id: @category.to_param}
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      delete :destroy, params: {id: @category.to_param}
      expect(response).to redirect_to(categories_url)
    end
  end

end
