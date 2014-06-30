module Jekyll

  class TopPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category_index.html')
      self.data['category'] = category

      category_title_prefix = site.config['category_title_prefix'] || @site.config["name"] + " " + @site.config["separator"] + " "
      title_category = category[0,1].capitalize + category[1,category.length-1]
      self.data['title'] = "#{category_title_prefix}#{title_category}"
    end
  end

  class TopPageGenerator < Generator
    safe true

    def generate(site)
      top_pages = site.pages.reject { |p| p.data["order"].nil?}.sort{|a, b| a.data["order"] <=> b.data["order"]}
      site.config["top_pages"] = top_pages
    

    end
  end

end