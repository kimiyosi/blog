module ApplicationHelper
  def full_error_message_on(object, method, css_class = 'uk-text-danger')
    obj = instance_variable_get("@#{object}")
    text = obj.class.human_attribute_name(method.to_s)
    errors = obj.errors[method.to_sym]
    if errors.size > 0
      content_tag("div", "#{text} #{errors.is_a?(Array) ? errors.first : errors}", :class => css_class)
    end
  end
  
  def nl2br(text)
    return "" unless text
  
    str = text.to_s
    str.gsub!("/\r\n/", "\n")
    str.gsub!("/\r/", "\n")
    str.gsub!("\n", "<br />")
    return str.html_safe
  end
  
end
