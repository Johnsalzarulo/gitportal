module Gitportal
  module ApplicationHelper
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

    def labels(labels)
      return "" if labels.empty?
        html_labels = ""
        labels.each do |label|
          html_labels += "<span class='label label-default' style='background-color: ##{label['color']}; margin-right: 4px;'>#{label['name']}</span>"
        end
        html_labels.html_safe
    end

    def all_labels(labels)
      return "" if labels.empty?
        buttons = ""
        labels.each do |label|
          buttons += "<a href='/issues?label=#{label['name']}' class='label label-default' style='background-color: ##{label['color']}; display: inline-block; margin-right: 4px;'> #{label['name']}</a>"
        end
        buttons.html_safe
    end

  end
end
