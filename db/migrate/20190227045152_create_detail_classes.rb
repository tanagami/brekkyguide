class CreateDetailClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :detail_classes do |t|
      t.string :code
      t.string :middle_class_id
      t.string :small_class_id
      t.string :name

      t.timestamps
    end
  end
end
