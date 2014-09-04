class CacheAdvertCount < ActiveRecord::Migration
  def up
    execute "update categories set adverts_count=(select count(*) from adverts where category_id=categories.id)"
  end
end
