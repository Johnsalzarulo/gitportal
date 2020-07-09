module Gitportal::ApplicationHelper

  def method_missing method, *args, &block
    method.to_s.end_with?('_path', '_url') and main_app.respond_to?(method) ? main_app.send(method, *args) : super
  end

  def markdown(text)
    options = {
      filter_html:     false,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: '_blank' },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: false
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def labels(labels, css_classes="")
    return "" if labels == nil
      html_labels = ""
      labels.each do |label|
        color = label.respond_to?(:color) ? label.color : label['color']
        name = label.respond_to?(:name) ? label.name : label['name']
        html_labels += "<span class='#{css_classes}' style='background-color: ##{color}; margin-right: 4px;'>#{name}</span>"
      end
      html_labels.html_safe
  end

  def all_labels(labels, link=true, css_classes="")
    return "" if labels == nil
      buttons = ""
      labels.each do |label|
        if link
          buttons += "<a href='/gitportal/issues?label=#{label['name']}' class='label label-default' style='background-color: ##{label['color']}; display: inline-block; margin-right: 4px;'> #{label['name']}</a>"
        else
          buttons += "<span class='#{css_classes}' style='background-color: ##{label['color']}; display: inline-block; margin-right: 4px;'> #{label['name']}</span>"
        end
      end
      buttons.html_safe
  end

end
