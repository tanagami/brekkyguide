class CreateSmallClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :small_classes do |t|
      t.string :code
      t.string :middle_class_id
      t.string :name

      t.timestamps
    end
  end
end
