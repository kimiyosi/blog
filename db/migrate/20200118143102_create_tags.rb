class CreateTags < ActiveRecord::Migration[6.0]

  def up
    create_table :tags do |t|
      t.integer  :code,    null: false
      t.string   :name,        null: false
      
      t.timestamps
    end

    add_index :tags, :code, unique: true
    add_index :tags, :name,     unique: true
  end

  def down
    drop_table :tags
  end
end
