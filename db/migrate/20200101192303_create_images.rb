class CreateImages < ActiveRecord::Migration[6.0]
  def up
    create_table :images do |t|
      t.integer :code, null: false
      t.string  :name, null: false
      t.binary  :img,  null: false
      t.timestamps
    end

    add_index :images, :code, unique: true
    add_index :images, :name
  end

  def down
    drop_table :images
  end
end
