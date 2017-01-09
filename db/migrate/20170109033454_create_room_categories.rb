class CreateRoomCategories < ActiveRecord::Migration
  def change
    create_table :room_categories do |t|
      t.integer :room_id
      t.integer :category_id
    end
  end
end
