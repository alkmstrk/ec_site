class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name, null: false
      t.string :image_id, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.integer :sales_status, default: 0

      t.timestamps
    end
  end
end
