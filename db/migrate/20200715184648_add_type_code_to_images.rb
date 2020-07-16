class AddTypeCodeToImages < ActiveRecord::Migration[6.0]
  def up
    add_column :images, :type_code, :integer

    add_index :images, :type_code
  end

  def down
    remove_column :images, :type_code, :integer
  end
end
