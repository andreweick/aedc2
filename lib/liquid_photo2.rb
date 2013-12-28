class Photo2 < Liquid::Tag

  def initialize(tag_name, args, tokens)
    super
    @url, @text = *args.scan(%r{"[^"]*"|\S+})
		
		@year = @url.split("/")[-3]
		@directory = @url.split("/")[-2]
		@filename = @url.split("/")[-1]

    @text = @text.tr('"', '')
  end

  # def render(context)
  #   "<figure><img src='http://media.eick.us/images/generated/#{@year}/#{@directory}/960/#{@filename}' title='#{@text}'/><figcaption>#{@text}</figcaption></figure>"
  # end

  def render(context)
    "<div data-picture='' data-alt='#{@text}'>"\
      "<div data-src='http://media.eick.us/images/generated/#{@year}/#{@directory}/480/#{@filename}' data-media='(min-width: 320px)'></div>"\
      "<div data-src='http://media.eick.us/images/generated/#{@year}/#{@directory}/768/#{@filename}' data-media='(min-width: 480px)'></div>"\
      "<div data-src='http://media.eick.us/images/generated/#{@year}/#{@directory}/900/#{@filename}' data-media='(min-width: 768px)'></div>"\
      "<div data-src='http://media.eick.us/images/generated/#{@year}/#{@directory}/640/#{@filename}' data-media='(-webkit-min-device-pixel-ratio: 1.5),(-moz-min-device-pixel-ratio: 1.5),(-o-min-device-pixel-ratio: 3/2)'></div>"\
      "<div data-src='http://media.eick.us/images/generated/#{@year}/#{@directory}/960/#{@filename}' data-media='(min-width: 320px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-o-min-device-pixel-ratio: 3/2)'></div>"\
      "<div data-src='http://media.eick.us/images/generated/#{@year}/#{@directory}/1536/#{@filename}' data-media='(min-width: 480px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-o-min-device-pixel-ratio: 3/2)'></div>"\
      "<div data-src='http://media.eick.us/images/generated/#{@year}/#{@directory}/1800/#{@filename}' data-media='(min-width: 768px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-o-min-device-pixel-ratio: 3/2)'></div>"\
      "<noscript>"\
        "<img src='http://media.eick.us/images/generated/#{@year}/#{@directory}/640/#{@filename}' alt='#{@text}'>"\
      "</noscript>"\
    "</div>"\
    "<span id='photo-caption'>#{@text}</span><span id='photo-copyright'>#{@year}</span>"
  end

end

Liquid::Template.register_tag('photo2', Photo2)


#   *Original*
#   1. base-url/images/original/2012/2012-01-14/(photograph)
#   *Generated*
#   1. base-url/images/generated/2012/2012-01-14/1800/(photograph)
#   2. base-url/images/generated/2012/2012-01-14/320/(photograph)
#   3. base-url/images/generated/2012/2012-01-14/480/(photograph)
#   4. base-url/images/generated/2012/2012-01-14/500/(photograph)
#   5. base-url/images/generated/2012/2012-01-14/640/(photograph)
#   6. base-url/images/generated/2012/2012-01-14/768/(photograph)
#   7. base-url/images/generated/2012/2012-01-14/900/(photograph)
#   8. base-url/images/generated/2012/2012-01-14/960(photograph)
#   9. base-url/images/generated/2012/2012-01-14/1536/(photograph)
#  10. base-url/images/generated/2012/2012-01-14/1800/(photograph)
