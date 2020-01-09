class Report < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :sub_category_code, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :info, presence: true
  validates :is_hide, inclusion: [true, false]

  belongs_to :category, foreign_key: "category_code", primary_key: "code"
  belongs_to :sub_category, foreign_key: "sub_category_code", primary_key: "code"
  belongs_to :image, foreign_key: "image_code", primary_key: "code"

  def self.new_code
    code = 1
    last = self.order(code: :desc).first
    if last
      code = last.code + 1
    end

    return code
  end
end
