class SubCategory < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :category_code, presence: true
  validates :order_code, presence: true
  validates :name, presence: true
  validates :en_name, presence: true

  belongs_to :category, foreign_key: "category_code", primary_key: "code"
  has_many :reports, foreign_key: "sub_category_code", primary_key: "code"

  def self.new_code
    code = 1
    last = self.order(code: :desc).first
    if last
      code = last.code + 1
    end

    return code
  end
end
