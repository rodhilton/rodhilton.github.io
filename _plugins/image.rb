module Jekyll

  class Image < Liquid::Tag

    require 'rubygems'
    require 'mini_magick'

    def initialize(tag_name, markup, tokens)
      @markup = markup
      @tokens = tokens
      super
    end

    def render(context)
      render_markup = Liquid::Template.parse(@markup).render(context).gsub(/\\\{\\\{|\\\{\\%/, '\{\{' => '{{', '\{\%' => '{%')

      site = context.registers[:site]
      img, rest = render_markup.match(/^["']?(.*?)["']? (.*)$/).captures

      markup = /^(?:(?<preset>[^\s.:\/]+)\s+)?(?<image_src>[^\s]+\.[a-zA-Z0-9]{3,4})\s*(?<html_attr>[\s\S]+)?$/.match(render_markup)

      if(markup.nil?)
        markup = {}
      end

      html_attr = if markup[:html_attr]
        Hash[ *markup[:html_attr].scan(/(?<attr>[^\s="]+)(?:="(?<value>[^"]+)")?\s?/).flatten ]
      else
        {}
      end

      if img =~ /^(http:)?\/\//
        img_url = img
      else
        img_url = "/assets/#{img}"
        file = File.join(site.source, img_url)
        if File.exist?(file)
          image = MiniMagick::Image.open(file)
          unless html_attr.include?("width") or html_attr.include?("height") 
            html_attr["width"] = image[:width]
            html_attr["height"] = image[:height]
          end
        end
      end

      wrap_caption(wrap_link(img_url, render_img(img_url, html_attr), html_attr), html_attr)
    end

    def render_img(img, attributes)
      ret = "<img src='#{img}'"

      ret = ret + " width='#{attributes['width']}'" if attributes.include?("width")
      ret = ret + " height='#{attributes['height']}'" if attributes.include?("height")

      ret = ret + "/>"
      ret
    end

    def wrap_link(img, html, attributes)
      link = attributes["link"]

      if not attributes.include?("link")
        html
      elsif link == "self" or link.nil? #Just putting "link" with no value should assume self
        "<a href='#{img}'>#{html}</a>"
      else 
        "<a href='#{link}'>#{html}</a>"
      end
    end

    def wrap_caption(html, attributes)
      #This is terrible code.. the idea here is to build up the table, bearing in mind that
      #if we have a width we want to set it on the outer table to be padding*2 more.  This
      #is thus tied to the style sheet quite a bit
      alignment = "center"
      alignment = attributes["align"] || "center"

      caption = attributes["caption"]

      ret = ""
      ret = ret + "<table class='image align#{alignment}'"

      ret = ret + " width='#{attributes['width']+6}'" if attributes.include?("width")

      ret = ret + "><tr><td>#{html}"

      unless caption.nil?
        ret = ret + "<p class='caption'>#{caption}</p>"
      end
      
      ret = ret + "</td></tr></table>"

      ret
    end
  end

  class EmbedBlock < Liquid::Block

    def initialize(tag_name, text, tokens)
      super
      @text = text
      @tokens = tokens
    end

    def render(context)
      inner = super.strip
      
      ret = ""
      ret = ret + "<table class='image aligncenter'><tr><td>"
      ret = ret + inner
      ret = ret + "</td></tr></table>"

      ret
    end
  end


end

Liquid::Template.register_tag('image', Jekyll::Image)
Liquid::Template.register_tag('img', Jekyll::Image)
Liquid::Template.register_tag('embed', Jekyll::EmbedBlock)