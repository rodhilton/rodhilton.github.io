module Jekyll

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      site.static_files << Jekyll::StaticFile.new(site, site.source, "test/two", "blah")
    end
  end

end