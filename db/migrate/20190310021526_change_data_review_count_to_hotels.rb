class ChangeDataReviewCountToHotels < ActiveRecord::Migration[5.0]
  def change
    if Rails.env.production?
      change_column :hotels, :review_count, 'integer USING CAST(review_count AS integer)'
      change_column :hotels, :review_average, 'float USING CAST(review_average AS integer)'
      change_column :hotels, :meal_average, 'float USING CAST(meal_average AS integer)'
      change_column :hotels, :no, 'integer USING CAST(no AS integer)'
      change_column :hotels, :min_charge, 'integer USING CAST(min_charge AS integer)'
    else
      change_column :hotels, :review_count, :int
      change_column :hotels, :review_average, :float
      change_column :hotels, :meal_average, :float
      change_column :hotels, :no, :int
      change_column :hotels, :min_charge, :int      
    end
  end
end