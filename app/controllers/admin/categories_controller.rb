class Admin::CategoriesController < Admin::AdminController
  load_and_authorize_resource
  respond_to :json

  def index
    @categories = Category.recent.paginate(page: params[:page], per_page: 20)
  end

  def new
    form_html = string_form(@category)
    respond_with html: form_html
  end

  def edit
    form_html = string_form(@category)
    respond_with html: form_html
  end

  def create
    is_create = @category.save
    if is_create
      category_html = string_category(@category)
    else
      form_html = string_form(@category)
    end
    render json: { create_status: is_create, form_html: form_html, category_html: category_html }
  end

  def update
    is_create = @category.update(category_params)
    if is_create
      category_html = string_category(@category)
    else
      form_html = string_form(@category)
    end
    render json: { create_status: is_create, form_html: form_html, category_html: category_html, id: @category.id }
  end

  private
  def string_form(category)
    render_to_string(partial: 'admin/categories/form', formats: [:html], locals: { category: category })
  end

  def string_category(category)
    render_to_string(partial: 'admin/categories/category', formats: [:html], locals: { category: category })
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
