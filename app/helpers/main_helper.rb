module MainHelper

  def grid_contents(report, card_css: "", title_css: "uk-card-title", desc_css: "description")
    str = ""
    
    str << "<div class=\"uk-card uk-card-default #{card_css}\">"
    str << "  <div class=\"uk-card-media-top\">"
    str << "    #{link_to image_tag(show_image_path(report.image.code)), main_report_path(category_name: report.category.en_name, sub_category_name: report.sub_category.en_name, code: report.code)}"
    str << "  </div>"
    str << "  <div class=\"uk-card-body\">"
    str << "    <h3 class=\"#{title_css}\">#{link_to report.title, main_report_path(category_name: report.category.en_name, sub_category_name: report.sub_category.en_name, code: report.code)}</h3>"
    str << "    <p class=\"uk-article-meta\"><time datetime=\"#{report.created_at.strftime("%Y-%m-%d")}\">#{report.created_at.strftime("%Y-%m-%d")}</time> <span class=\"uk-label green_bg\">#{link_to report.category.name, main_category_path(category_name: report.category.en_name), {class: "white"}}</span> <span class=\"uk-label light_green_bg\">#{link_to report.sub_category.name, main_sub_category_path(category_name: report.category.en_name, sub_category_name: report.sub_category.en_name), {class: "white"}}</span></p>"
    str << "    <p class=\"#{desc_css}\">#{report.description}</p>"
    str << "  </div>"
    str << "</div>"
    
    return str.html_safe
  end

end
