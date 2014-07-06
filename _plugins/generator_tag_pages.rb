module Jekyll

  Tag = Struct.new(:name, :posts) do 

    def id 
      self.name.downcase.gsub(/[^a-z0-9]/, "-").gsub(/-+/,"-").gsub(/^-+/, "").gsub(/-+$/, "")
    end

    def to_liquid
      {
       'name'=>self.name,
       'posts'=>self.posts,
       'id'=>self.id
      }
    end
  end

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_index.html')
      self.data['tag'] = tag

      tag_title_prefix = site.config['tag_title_prefix'] || @site.config["name"] + " " + @site.config["separator"] + " "
      title_tag = tag.name[0,1].capitalize + tag.name[1,tag.name.length-1]
      self.data['title'] = "#{tag_title_prefix}#{title_tag}"
    end
  end

  class TagRss < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'rss.xml'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_rss.xml')
      self.data['tag'] = tag

      tag_title_prefix = site.config['tag_title_prefix'] || @site.config["name"] + " " + @site.config["separator"] + " "
      title_tag = tag.name[0,1].capitalize + tag.name[1,tag.name.length-1]
      self.data['title'] = "#{tag_title_prefix}#{title_tag}"
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      site.config["ordered_tags"] = site.tags.collect{|k, v| Tag.new(k, v)}.reject{|t| t.posts.size < 2}.sort{|a, b| a.posts.size <=> b.posts.size}.reverse

      if site.layouts.key? 'tag_index'
        dir = site.config['tag_dir'] || 'tags'
        site.tags.keys.each do |tag|
          tag_obj = Tag.new(tag, site.tags[tag])

          site.pages << TagPage.new(site, site.source, File.join(dir, tag_obj.id), tag_obj)
          site.pages << TagRss.new(site, site.source, File.join(dir, tag_obj.id), tag_obj)
        end
      end
    end
  end

end