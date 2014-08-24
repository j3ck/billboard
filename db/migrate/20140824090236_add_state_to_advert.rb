class AddStateToAdvert < ActiveRecord::Migration
  def change
    add_column :adverts, :state, :string
  end
end
