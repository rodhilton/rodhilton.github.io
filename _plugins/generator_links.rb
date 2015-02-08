module Jekyll

  class LinksGenerator < Generator
    safe true

    def generate(site)
      site.data["sorted_links"]=site.data["links"].sort_by{|l| l["name"]}
    end
  end

end