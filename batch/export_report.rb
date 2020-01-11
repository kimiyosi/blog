require 'csv'
class ExportReport
  SAVE_PATH = "#{Rails.root}/res/report.csv"
  HEADER_ROW = ["code", "category_code", "sub_category_code", "image_code", "title", "description", "info", "is_hide"]

  def run
    CSV.open(SAVE_PATH, "w:utf-8"){|f|
      f << HEADER_ROW

      items = Report.order('created_at asc')
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
    row << item.sub_category_code
    row << item.image_code
    row << item.title
    row << item.description
    row << item.info.to_s.gsub(/\r\n/, "\n").gsub(/\n/, "<br />")
    row << item.is_hide

    return row
  end

end

ExportReport.new.run