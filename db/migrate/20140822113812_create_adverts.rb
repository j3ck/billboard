class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.references :user, index: true
      t.references :category, index: true
      t.references :type, index: true

      t.timestamps
    end
  end
end
