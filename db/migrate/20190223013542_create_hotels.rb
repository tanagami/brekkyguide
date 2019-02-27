class CreateHotels < ActiveRecord::Migration[5.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :kananame
      t.string :special
      t.string :address1
      t.string :address2
      t.string :access
      t.string :image_url
      t.string :thumbnail_url
      t.string :review_count
      t.string :review_average
      t.string :meal_average
      t.string :breakfast_place

      t.timestamps
    end
  end
end
