class ChangeDataReviewCountToHotels < ActiveRecord::Migration[5.0]
  def change
    change_column :hotels, :review_count, :int
    change_column :hotels, :review_average, :float
    change_column :hotels, :meal_average, :float
    change_column :hotels, :no, :int
    change_column :hotels, :min_charge, :int
  end
end