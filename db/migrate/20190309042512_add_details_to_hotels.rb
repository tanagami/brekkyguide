class AddDetailsToHotels < ActiveRecord::Migration[5.0]
  def change
    add_column :hotels, :no, :string
    add_column :hotels, :information_url, :string
    add_column :hotels, :min_charge, :string
  end
end
