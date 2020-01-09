class Category < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :order_code, presence: true
  validates :name, presence: true
  validates :en_name, presence: true

  has_many :sub_categories, foreign_key: "category_code", primary_key: "code"

  def self.new_code
    code = 1
    last = self.order(code: :desc).first
    if last
      code = last.code + 1
    end

    return code
  end
end
