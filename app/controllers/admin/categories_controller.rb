class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :set_category, only: [:edit, :update]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
