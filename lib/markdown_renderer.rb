require 'redcarpet'

module MarkdownRenderer
  class << self
    def renderer
      @renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true,
                                                                     fenced_code_blocks: true)
    end

    def render(text)
      text.blank? ? '' : renderer.render(text).html_safe
    end
  end
end
