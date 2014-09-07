class AddAdvertsCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :adverts_count, :integer
  end
end
