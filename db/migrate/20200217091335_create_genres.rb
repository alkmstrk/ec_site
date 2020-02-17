class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :title, null: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
