class CreateReports < ActiveRecord::Migration[6.0]
  def up
    create_table :reports do |t|
      t.integer :code,              null: false
      t.integer :category_code,     null: false
      t.integer :sub_category_code, null: false
      t.integer :image_code
      t.string  :title,             null: false
      t.string  :description,       null: false
      t.text    :info,              null: false
      t.boolean :is_hide,           null: false, default: false
      t.timestamps
    end

    add_index :reports, :code, unique: true
    add_index :reports, :category_code
    add_index :reports, :sub_category_code
    add_index :reports, :image_code
    add_index :reports, :title
    add_index :reports, :is_hide
  end

  def down
    drop_table :reports
  end
end
