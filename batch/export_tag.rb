require 'csv'
class ExportTag
  SAVE_PATH = "#{Rails.root}/res/tag.csv"
  HEADER_ROW = ["code", "name"]

  def run
    CSV.open(SAVE_PATH, "w:utf-8"){|f|
      f << HEADER_ROW

      items = Tag.order('created_at asc')
      items.each do |item|
        row = row_from_item(item)
        f << row
      end
    }
  end

  def row_from_item(item)
    row = []

    row << item.code
    row << item.name

    return row
  end

end

ExportTag.new.run