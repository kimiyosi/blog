class Tag < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  has_many :report_tags, foreign_key: "tag_code", primary_key: "code", dependent: :destroy
  has_many :reports, through: :report_tags, foreign_key: "report_code", primary_key: "code"

  def self.new_code
    code = 1
    last = self.order(code: :desc).first
    if last
      code = last.code + 1
    end

    return code
  end
end