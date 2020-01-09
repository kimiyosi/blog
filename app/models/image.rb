class Image < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :img,  presence: true

  has_many :reports, foreign_key: "report_code", primary_key: "code"

  def self.new_code
    code = 1
    last = self.order(code: :desc).first
    if last
      code = last.code + 1
    end

    return code
  end
end
