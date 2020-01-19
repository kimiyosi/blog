class ReportTag < ApplicationRecord
  validates :tag_code, presence: true, uniqueness: { scope: [:report_code] }
  validates :report_code, presence: true

  belongs_to :report, foreign_key: "report_code", primary_key: "code"
  belongs_to :tag,    foreign_key: "tag_code", primary_key: "code"

  def self.add(report_code, tag_codes)
    unless tag_codes.blank?
      tag_codes.each do |tag_code|
        self.create(report_code: report_code, tag_code: tag_code)
      end
    end
  end

  def self.update_report(report_code, tag_codes)
    report_tags = self.where(report_code: report_code)
    if report_tags
      report_tags.each { |report_tag|
        report_tag.destroy
      }
      
      self.add(report_code, tag_codes)
    end
  end
  
end
