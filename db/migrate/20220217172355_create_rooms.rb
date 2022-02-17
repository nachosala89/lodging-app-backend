class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.text :description
      t.string :image
      t.float :price
      t.integer :people_amount
      t.boolean :deleted

      t.timestamps
    end
  end
end
