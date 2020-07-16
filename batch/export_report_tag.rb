require 'csv'
class ExportReportTag
  SAVE_PATH = "#{Rails.root}/res/report_tag.csv"
  HEADER_ROW = ["report_code", "tag_code"]

  def run
    CSV.open(SAVE_PATH, "w:utf-8"){|f|
      f << HEADER_ROW

      items = ReportTag.order('created_at asc')
      items.each do |item|
        row = row_from_item(item)
        f << row
      end
    }
  end

  def row_from_item(item)
    row = []

    row << item.report_code
    row << item.tag_code

    return row
  end

end

ExportReportTag.new.run