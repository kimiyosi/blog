class CreateReportTags < ActiveRecord::Migration[6.0]

  def up
    create_table :report_tags do |t|
      t.integer  :tag_code,      null: false
      t.integer  :report_code,   null: false
      
      t.timestamps
    end

    add_index :report_tags, [:tag_code, :report_code], unique: true
  end

  def down
    drop_table :report_tags
  end

end
