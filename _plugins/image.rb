module Jekyll

  class Image < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      @markup = markup
      @tokens = tokens
      super
    end

    def render(context)
      render_markup = Liquid::Template.parse(@markup).render(context).gsub(/\\\{\\\{|\\\{\\%/, '\{\{' => '{{', '\{\%' => '{%')

      img, rest = render_markup.match(/^["']?(.*?)["']? (.*)$/).captures

      markup = /^(?:(?<preset>[^\s.:\/]+)\s+)?(?<image_src>[^\s]+\.[a-zA-Z0-9]{3,4})\s*(?<html_attr>[\s\S]+)?$/.match(render_markup)

      html_attr = if markup[:html_attr]
        Hash[ *markup[:html_attr].scan(/(?<attr>[^\s="]+)(?:="(?<value>[^"]+)")?\s?/).flatten ]
      else
        {}
      end

      if img =~ /^(http:)?\/\//
        img_url = img
      else
        img_url = "/assets/#{img}"
      end

      wrap_caption(wrap_link(img_url, render_img(img_url, html_attr), html_attr), html_attr)
    end

    private def render_img(img, attributes)
      ret = "<img src='#{img}'"

      ret = ret + " width='#{attributes['width']}'" if attributes.include?("width")
      ret = ret + " height='#{attributes['height']}'" if attributes.include?("height")

      ret = ret + "/>"
      ret
    end

    private def wrap_link(img, html, attributes)
      link = attributes["link"]

      if not attributes.include?("link")
        html
      elsif link == "self" or link.nil?
        "<a href='#{img}'>#{html}</a>"
      else 
        "<a href='#{link}'>#{html}</a>"
      end
    end

    private def wrap_caption(html, attributes)
      alignment = "center"
      alignment = attributes["align"] || "center"

      caption = attributes["caption"]

ret = ""
      ret = ret + "<table class='image align#{alignment}'>"+
        "<tr><td>#{html}"

      unless caption.nil?
        ret = ret + "<p class='caption'>#{caption}</p>"
      end
      
      ret = ret + "</td></tr></table>"

      ret
    end
  end

end

Liquid::Template.register_tag('image', Jekyll::Image)