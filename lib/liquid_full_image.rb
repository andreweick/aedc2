class FullImage < Liquid::Tag

  def initialize(tag_name, args, tokens)
    super
    @url, @text = *args.scan(%r{"[^"]*"|\S+})
    @text = @text.tr('"', '')
  end

  def render(context)
    "<figure class='full-width'><img src=#{@url} title='#{@text}'/></figure>"
  end
end

Liquid::Template.register_tag('full_image', FullImage)
