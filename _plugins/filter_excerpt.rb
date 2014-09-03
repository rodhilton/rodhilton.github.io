module ExcerptFilter
  MORE_REGEX = /<!--\s*more\s*-->/

  def excerpt(input)

    if input =~ MORE_REGEX
      idx = input.index(MORE_REGEX)
      excerpt = input[0, idx-1]
    else

      paragraphs = input.scan(/<p>.*?<\/p>/)

      excerpt = paragraphs.take(4).join("")
    end

    tags = excerpt.scan(/<(\/?(\w+)[^>]*)>/)
    open_tags = []

    tags.each do |tag_a|
      full_tag = tag_a[0]
      tag_name = tag_a[1]

      is_close_tag = full_tag.chars[0..0] == "/"
      is_unpaired_tag = full_tag[-1..-1] == "/"

      if is_close_tag
        if(open_tags[-1] == tag_name)
          open_tags.pop()
        else
          puts "Tag #{tag_name} was opened and never closed.  We need some debug info here"
          puts "Current open_tags:"
          require 'pp'
          pp open_tags
          puts excerpt
          Kernel.exit(-1)
        end
      elsif is_unpaired_tag
        #Ignore
      else
        open_tags.push(tag_name)
      end
    end

    excerpt + open_tags.reverse.collect{|t| "</#{t}>"}.join(" ")
  end

  Liquid::Template.register_filter self
end