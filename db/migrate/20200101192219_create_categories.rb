class CreateCategories < ActiveRecord::Migration[6.0]
  def up
    create_table :categories do |t|
      t.integer :code,        null: false
      t.integer :order_code,  null: false
      t.string  :name,        null: false
      t.string  :en_name,     null: false
      t.timestamps
    end

    add_index :categories, :code, unique: true
    add_index :categories, :order_code
    add_index :categories, :name
    add_index :categories, :en_name
  end

  def down
    drop_table :categories
  end
end
