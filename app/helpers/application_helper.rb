module ApplicationHelper
  # Renders a Tango Desktop Project icon from app/assets/images/tango/<size>x<size>/<name>.png.
  # Sizes are 16 (inline, lists) and 22 (toolbars, headings). See app/assets/images/tango/README.md.
  def tango_icon(name, size: 16, alt: "")
    image_tag("tango/#{size}x#{size}/#{name}.png", alt: alt, width: size, height: size, class: "tango-icon")
  rescue Propshaft::MissingAssetError
    # Keeps pages rendering when the icons are not there.
    tag.span(class: "tango-icon tango-icon-missing", style: "width:#{size}px;height:#{size}px")
  end
end
