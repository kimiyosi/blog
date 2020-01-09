class AjaxController < ApplicationController

  def get_sub_categories
    @sub_categories = SubCategory.where(category_code: params[:report][:category_code])
  end

end