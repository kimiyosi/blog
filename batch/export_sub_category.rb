require 'csv'
class ExportSubCategory
  SAVE_PATH = "#{Rails.root}/res/sub_category.csv"
  HEADER_ROW = ["code", "category_code", "order_code", "name", "en_name"]

  def run
    CSV.open(SAVE_PATH, "w:utf-8"){|f|
      f << HEADER_ROW

      items = SubCategory.order('created_at asc')
      items.each do |item|
        row = row_from_item(item)
        f << row
      end
    }
  end

  def row_from_item(item)
    row = []

    row << item.code
    row << item.category_code
    row << item.order_code
    row << item.name
    row << item.en_name

    return row
  end

end

ExportSubCategory.new.run