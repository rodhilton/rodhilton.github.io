module AddSiteUrlFilter
  def abs_urls(input)

	site_url = @context.registers[:site].config['url']

	#This looks for any src= or href=, with optional (but matching) quotes, and prepends the site url.
	#It will not do this for urls starting with //, hence the negative lookahead
	input.gsub(/(href|src)\s*=\s*(["'])\/(?!\/)(.*?)\2/, "\\1=\"#{site_url}/\\3\"")
  end

  Liquid::Template.register_filter self
end