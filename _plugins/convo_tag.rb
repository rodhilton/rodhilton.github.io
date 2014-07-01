module Jekyll
  class ConvoBlock < Liquid::Block

    def initialize(tag_name, text, tokens)
      super
      @text = text
      @tokens = tokens
    end

    def render(context)
      inner = super.strip
      regex = /\s*([^:]+)\s*:\s*(.*)\s*/
      lines = inner.split(/\r?\n/).select {|line| line.strip != "" && regex.match(line)}

      lines_formatted = lines.collect do |line| 
        who, what = regex.match(line).captures
        "<dt class='chat-highlight'><strong>#{who}:</strong></dt><dd>#{what}</dd>"
      end

      "<dl class='chat-transcript'>" + 
      lines_formatted.join("\n") + 
      "</dl>"
    end
  end

end

Liquid::Template.register_tag('convo', Jekyll::ConvoBlock)
Liquid::Template.register_tag('conversation', Jekyll::ConvoBlock)
Liquid::Template.register_tag('transcript', Jekyll::ConvoBlock)