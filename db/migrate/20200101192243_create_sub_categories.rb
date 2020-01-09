class CreateSubCategories < ActiveRecord::Migration[6.0]
  def up
    create_table :sub_categories do |t|
      t.integer :code,          :null => false
      t.integer :category_code, :null => false
      t.integer :order_code,    :null => false
      t.string  :name,          :null => false
      t.string  :en_name,       :null => false
      t.timestamps
    end

    add_index :sub_categories, :code, :unique => true
    add_index :sub_categories, :category_code
    add_index :sub_categories, :order_code
    add_index :sub_categories, :name
    add_index :sub_categories, :en_name
  end

  def down
    drop_table :sub_categories
  end
end
