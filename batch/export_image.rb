require 'csv'
class ExportImage
  SAVE_PATH = "#{Rails.root}/res/image.csv"
  HEADER_ROW = ["code", "name", "type_code", "img"]

  def run
    CSV.open(SAVE_PATH, "w:utf-8"){|f|
      f << HEADER_ROW

      items = Image.order('created_at asc')
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
    row << item.type_code
    row << Base64.strict_encode64(item.img)

    return row
  end

end

ExportImage.new.run