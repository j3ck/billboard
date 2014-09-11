class CreateImage < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :data
      t.integer :advert_id
    end
  end
end
