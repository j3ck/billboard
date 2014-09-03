class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references :advert, index: true
      t.integer :editor_id
      t.string :editor_role
      t.string :action
      t.text :comment
      t.string :last_state
      t.string :current_state

      t.datetime :created_at
    end
  end
end
