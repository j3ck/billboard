class AddAdvertidToImage < ActiveRecord::Migration
  def change
    add_column :images, :advert_id, :integer
  end
end
