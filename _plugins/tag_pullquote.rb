module Jekyll

  class PullQuote < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      "<span data-pullquote=\"#{@text}\" class=\"left\">#{@text}</span>"
    end

  end

  class PullQuoteRight < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      "<span data-pullquote=\"#{@text}\" class=\"right\">#{@text}</span>"
    end

  end

  class AltPullQuote < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      "<span data-pullquote=\"#{@text}\" class=\"left\"></span>"
    end
    
  end

  class AltPullQuoteRight < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      "<span data-pullquote=\"#{@text}\" class=\"right\"></span>"
    end
    
  end

end

Liquid::Template.register_tag('pullquote', Jekyll::PullQuote)
Liquid::Template.register_tag('pq', Jekyll::PullQuote)

Liquid::Template.register_tag('pullquoter', Jekyll::PullQuoteRight)
Liquid::Template.register_tag('pqr', Jekyll::PullQuoteRight)

Liquid::Template.register_tag('altpullquote', Jekyll::AltPullQuote)
Liquid::Template.register_tag('apq', Jekyll::AltPullQuote)

Liquid::Template.register_tag('altpullquoter', Jekyll::AltPullQuoteRight)
Liquid::Template.register_tag('apqr', Jekyll::AltPullQuoteRight)