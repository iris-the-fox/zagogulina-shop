class CategoriesController < ApplicationController
  before_action :authenticate_admin
  skip_before_action :authenticate_admin, only: [:show, :index]
  protect_from_forgery with: :null_session
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_categories_new, only: [:new, :create]
  before_action :set_categories_edit, only: [:edit, :update]
  before_action :set_products, only: [:show]
     
  include SortableTreeController::Sort
  sortable_tree 'Category', {parent_method: 'parent', sorting_attribute: 'pos'}
 

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  def manage
    @categories = Category.all.arrange(:order => :pos)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    def set_categories_new
      @categories = Category.all.order(:title)
    end

    def set_categories_edit
      set_category
      @categories = Category.where("id != #{@category.id}").order(:title)
    end
    
    def set_products
      Product.where(category_id: [@category.subtree_ids]).exists? ? @products = Product.where(category_id: [@category.subtree_ids]) : nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:title, :parent_id, :slug, :pos, :ancestry_depth)
    end


end
