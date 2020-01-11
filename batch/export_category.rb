require 'csv'
class ExportCategory
  SAVE_PATH = "#{Rails.root}/res/category.csv"
  HEADER_ROW = ["code", "order_code", "name", "en_name"]

  def run
    CSV.open(SAVE_PATH, "w:utf-8"){|f|
      f << HEADER_ROW

      items = Category.order('created_at asc')
      items.each do |item|
        row = row_from_item(item)
        f << row
      end
    }
  end

  def row_from_item(item)
    row = []

    row << item.code
    row << item.order_code
    row << item.name
    row << item.en_name

    return row
  end

end

ExportCategory.new.run