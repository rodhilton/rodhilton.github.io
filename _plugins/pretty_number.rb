module PrettyNumberFilter
  def pretty_number(input)
    input.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
  end

  Liquid::Template.register_filter self
end