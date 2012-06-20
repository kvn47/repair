module ApplicationHelper

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    dir = (column == sort_column) ? direction : 'both'
    link_to params.merge(sort: column, direction: direction, page: nil), {class: css_class, remote: false} do
      (title +
      image_tag("sort_#{dir}.png")).html_safe
    end
    # link_to title, params.merge(sort: column, direction: direction, page: nil), {class: css_class, remote: false}
  end
  
end
