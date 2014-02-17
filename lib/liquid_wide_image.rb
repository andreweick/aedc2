class WideImage < Liquid::Tag

  def initialize(tag_name, args, tokens)
    super
    @url, @text = *args.scan(%r{"[^"]*"|\S+})
    @text = @text.tr('"', '')
  end

  def render(context)
    "<figure class='wide'><img src=#{@url} title='#{@text}'/></figure>"
  end
end

Liquid::Template.register_tag('wide_image', WideImage)
