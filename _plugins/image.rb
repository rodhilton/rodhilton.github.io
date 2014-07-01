module Jekyll

  class Image < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      @markup = markup
      @tokens = tokens
      super
    end

    def render(context)

      # # Render any liquid variables in tag arguments and unescape template code
      render_markup = Liquid::Template.parse(@markup).render(context).gsub(/\\\{\\\{|\\\{\\%/, '\{\{' => '{{', '\{\%' => '{%')

        puts render_markup

      # # Gather settings
      # site = context.registers[:site]
      # settings = site.config['image']
      markup = /^(?:(?<preset>[^\s.:\/]+)\s+)?(?<image_src>[^\s]+\.[a-zA-Z0-9]{3,4})\s*(?<html_attr>[\s\S]+)?$/.match(render_markup)

      puts "tokens"
      puts @tokens

      puts markup
      # preset = settings['presets'][ markup[:preset] ]

      # raise "Image Tag can't read this tag. Try {% image [preset or WxH] path/to/img.jpg [attr=\"value\"] %}." unless markup

      # # Assign defaults
      # settings['source'] ||= '.'
      # settings['output'] ||= 'generated'

      # # Prevent Jekyll from erasing our generated files
      # site.config['keep_files'] << settings['output'] unless site.config['keep_files'].include?(settings['output'])

      # # Process instance
      # instance = if preset
      #   {
      #     :width => preset['width'],
      #     :height => preset['height'],
      #     :src => markup[:image_src]
      #   }
      # elsif dim = /^(?:(?<width>\d+)|auto)(?:x)(?:(?<height>\d+)|auto)$/i.match(markup[:preset])
      #   {
      #     :width => dim['width'],
      #     :height => dim['height'],
      #     :src => markup[:image_src]
      #   }
      # else
      #   { :src => markup[:image_src] }
      # end

      # # Process html attributes
      html_attr = if markup[:html_attr]
        Hash[ *markup[:html_attr].scan(/(?<attr>[^\s="]+)(?:="(?<value>[^"]+)")?\s?/).flatten ]
      else
        {}
      end

      puts "attr:"
      puts html_attr

      # if preset && preset['attr']
      #   html_attr = preset['attr'].merge(html_attr)
      # end

      # html_attr_string = html_attr.inject('') { |string, attrs|
      #   if attrs[1]
      #     string << "#{attrs[0]}=\"#{attrs[1]}\" "
      #   else
      #     string << "#{attrs[0]} "
      #   end
      # }

      # # Raise some exceptions before we start expensive processing
      # raise "Image Tag can't find the \"#{markup[:preset]}\" preset. Check image: presets in _config.yml for a list of presets." unless preset || dim ||  markup[:preset].nil?

      puts markup

      # # Return the markup!
      "<img src=\"stuff\" blah>"
    end
  end

end

Liquid::Template.register_tag('image', Jekyll::Image)