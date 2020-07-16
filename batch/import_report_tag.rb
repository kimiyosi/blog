# encoding: utf-8
require 'csv'
class ImportReportTag
  FILE_PATH = "#{Rails.root}/res/report_tag.csv"

  def run
    ActiveRecord::Base.transaction {
      unless File.exist?(FILE_PATH)
        raise "Error! Not File! #{FILE_PATH}"
      end

      import
    }
  end

  private

  def import
    rows = []
    first = true
    @count = 0
    header_row = {}

    CSV.foreach(FILE_PATH, :encoding => "utf-8"){|row|
      if first
        header_row = row
        first = false
        next
      end
      @count += 1

      attrs = {}
      header_row.each_with_index do |key, n|
        attrs[key.to_sym] = row[n]
      end

      item = ReportTag.find_by(:report_code => attrs[:report_code], :tag_code => attrs[:tag_code])
      if item
        item.attributes = attrs
        if item.valid?
          item.save!
          puts "#{@count}: Update OK!: report_code=#{item.report_code}, tag_code=#{item.tag_code}"
        else
          puts "#{@count}: Update Error!: #{item.inspect}"
        end

      else
        item = ReportTag.new(attrs)
        if item.valid?
          item.save!
          puts "#{@count}: Create OK!: report_code=#{item.report_code}, tag_code=#{item.tag_code}"
        else
          puts "#{@count}: Create Error!: #{item.inspect}"
        end
      end
    }
  end
end

ImportReportTag.new.run