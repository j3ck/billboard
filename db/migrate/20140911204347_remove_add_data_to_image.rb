class RemoveAddDataToImage < ActiveRecord::Migration
  def change
    remove_column :images, :data_file_name, :string
    remove_column :images, :data_content_type, :string
    remove_column :images, :data_file_size, :integer
    remove_column :images, :data_updated_at, :datetime

    add_column :images, :data, :string
  end
end
