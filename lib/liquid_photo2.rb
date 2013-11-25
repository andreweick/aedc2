class Photo2 < Liquid::Tag

  def initialize(tag_name, args, tokens)
    super
    @url, @text = *args.scan(%r{"[^"]*"|\S+})
    @text = @text.tr('"', '')
  end

  def render(context)
    "<figure><img src='#{@url}' title='#{@text}'/><figcaption>#{@text}</figcaption></figure>"
  end
end

Liquid::Template.register_tag('photo2', Photo2)
