class RemoveBreakfastPlaceFromHotels < ActiveRecord::Migration[5.0]
  def change
    remove_column :hotels, :breakfast_place, :string
  end
end
