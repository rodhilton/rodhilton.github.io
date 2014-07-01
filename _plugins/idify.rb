module IdifyFilter
  def idify(input)
    input.downcase.gsub(/[^a-z0-9]/, "-").gsub(/-+/,"-")
  end

  Liquid::Template.register_filter self
end