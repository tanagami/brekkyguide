class CreateMiddleClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :middle_classes do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
