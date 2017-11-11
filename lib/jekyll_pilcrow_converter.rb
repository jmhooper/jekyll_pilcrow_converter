require 'base64'
require 'digest'

module Jekyll
  class PilcrowConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext == '.md'
    end

    def output_ext(_ext)
      '.html'
    end

    def convert(content)
      document = Kramdown::Document.new(content)
      document.root = add_pilcrows(document.root)
      document.to_html
    end

    protected

    def add_pilcrows(element)
      element.children = element.children.inject([]) do |children, child_element|
        if paragraph_element?(child_element)
          paragraph = add_pilcrow_to_paragraph(child_element)
          children + [paragraph]
        elsif !child_element.children.empty?
          children + [add_pilcrows(child_element)]
        else
          children + [child_element]
        end
      end
      element
    end

    def paragraph_element?(element)
      return false if element.children.empty?
      return false unless element.type == :html_element && element.value == 'p'

      first_child = element.children.first

      return true if first_child.type == :text
      return true if first_child.type == :html_element && first_child.value == 'a'
      false
    end

    def add_pilcrow_to_paragraph(paragraph)
      id = generate_paragraph_id(paragraph)
      pilcrow = build_pilcrow_element(id)
      paragraph.attr[:id] = id
      paragraph.children = [pilcrow] + paragraph.children
      paragraph
    end

    def build_pilcrow_element(id)
      link = Kramdown::Element.new(
        :html_element,
        'a',
        href: "##{id}",
        class: 'pilcrow'
      )
      text = Kramdown::Element.new(:text, '¶ ')
      link.children = [text]
      link
    end

    def generate_paragraph_id(paragraph)
      text = get_element_text(paragraph)
      Base64.urlsafe_encode64(Digest::MD5.new.digest(text))
    end

    def get_element_text(element)
      element.children.map do |child_element|
        if child_element.type == :text
          child_element.value
        elsif !child_element.children.empty?
          get_element_text(child_element)
        else
          ''
        end
      end.join('')
    end
  end
end
