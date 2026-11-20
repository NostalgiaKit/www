module Bbcode
  # Renders forum BBCode to safe HTML. The Ruby BBCode gems are unmaintained,
  # so this is our own small parser: [b] [i] [u] [s] [url] [img] [quote] [code]
  # [list] [color] [size], and [scratchblocks] for block snippets.
  class Renderer
    def initialize(source)
      @source = source.to_s
    end

    def to_html
      # Placeholder: escaped plain text until the parser exists.
      ERB::Util.html_escape(@source)
    end
  end
end
