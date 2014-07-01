module Jekyll

  Tag = Struct.new(:name, :posts) do 
    def to_liquid
      {
       'name'=>self.name,
       'posts'=>self.posts
      }
    end
  end

  class TagPage < Page
    def initialize(site, base)
      @site = site
      @base = base
      @dir = "/"

      self.process("tags.html")
      self.read_yaml(File.join(base, '_layouts'), 'tag_index.html')
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      site.config["ordered_tags"] = site.tags.collect{|k, v| Tag.new(k, v)}.sort{|a, b| a.posts.size <=> b.posts.size}.reverse

      if site.layouts.key? 'tag_index'
        site.pages << TagPage.new(site, site.source)
      end
    end
  end

end