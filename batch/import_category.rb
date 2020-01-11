# encoding: utf-8
require 'csv'
class ImportCategory
  FILE_PATH = "#{Rails.root}/res/category.csv"

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

      item = Category.find_by(:code => attrs[:code])
      if item
        item.attributes = attrs
        if item.valid?
          item.save!
          puts "#{@count}: Update OK!: code=#{item.code}, name=#{item.name}"
        else
          puts "#{@count}: Update Error!: #{item.inspect}"
        end

      else
        item = Category.new(attrs)
        if item.valid?
          item.save!
          puts "#{@count}: Create OK!: code=#{item.code}, name=#{item.name}"
        else
          puts "#{@count}: Create Error!: #{item.inspect}"
        end
      end
    }
  end
end

ImportCategory.new.run