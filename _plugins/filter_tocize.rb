module TocizeFilter
  def tocize(input)
  	curLevel = 1;
    count = 0
  	toc = "<div class='toc no-hyphenate'><h1>Contents</h1><ol>"

    idified = input.gsub /^<h([123456])([^>]*)>(.*)<\/h\1>$/ do |x, t|
      newLevel = Regexp.last_match[1].to_i
      text = Regexp.last_match[3]
      id = "toc-"+text.downcase.gsub(/[^a-z0-9]/, "-").gsub(/-+/,"-").gsub(/^-+/, "").gsub(/-+$/, "")


      if(newLevel - curLevel > 0)  #We need to indent by the diff between curLevel and newLevel
        toc = toc + ("<ol>" * (newLevel-curLevel))
      elsif(newLevel - curLevel < 0)  #We need to outdent by the diff between curLevel and newLevel   
        toc = toc + ("</ol>" * -(newLevel-curLevel))
      end

      newLine =
        "<li>" +
          "<a href='\##{id}'>" +
            text +
          "</a>" +
        "</li>";

      curLevel = newLevel;
      count = count + 1
      toc = toc + newLine;

      "<h#{newLevel} id=#{id}>#{text}</h#{newLevel}>"
    end

	  toc = toc + "</ol></div>"

    if(count > 2) 
      toc + idified
    else
      idified
    end
  end

  Liquid::Template.register_filter self
end