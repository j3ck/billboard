class CategoriesController < ApplicationController
  def index
    @categories = Category.recent
  end

  def show
    @category = Category.find(params[:id])
  end
end
