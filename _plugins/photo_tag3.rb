module Jekyll
	class Photo3 < Liquid::Tag

	  def initialize(tag_name, args, tokens)
	    super

	    @img_url = 'http://media.eick.us/images'
	    # @img_url = 'http://192.168.1.31/media/images'
	    @url, @text = *args.scan(%r{"[^"]*"|\S+})
			
			@year = @url.split("/")[-3]
			@directory = @url.split("/")[-2]
			@filename = @url.split("/")[-1]

	    @base = @filename.split(".")[-2]
	    @ext = @filename.split(".")[-1]

	    @text = @text.tr('"', '')
	  end

	  def render(context)
	    "<div data-picture='' data-alt='#{@text}'>"\
	      "<div data-src='#{@img_url}/generated/#{@year}/#{@directory}/#{@base}-480x480.#{@ext}' data-media='(min-width: 320px)'></div>"\
	      "<div data-src='#{@img_url}/generated/#{@year}/#{@directory}/#{@base}-768x768.#{@ext}' data-media='(min-width: 480px)'></div>"\
	      "<div data-src='#{@img_url}/generated/#{@year}/#{@directory}/#{@base}-900x900.#{@ext}' data-media='(min-width: 768px)'></div>"\
	      "<div data-src='#{@img_url}/generated/#{@year}/#{@directory}/#{@base}-640x640.#{@ext}' data-media='(-webkit-min-device-pixel-ratio: 1.5),(-moz-min-device-pixel-ratio: 1.5),(-o-min-device-pixel-ratio: 3/2)'></div>"\
	      "<div data-src='#{@img_url}/generated/#{@year}/#{@directory}/#{@base}-960x960.#{@ext}' data-media='(min-width: 320px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-o-min-device-pixel-ratio: 3/2)'></div>"\
	      "<div data-src='#{@img_url}/generated/#{@year}/#{@directory}/#{@base}-1536x1536.#{@ext}' data-media='(min-width: 480px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-o-min-device-pixel-ratio: 3/2)'></div>"\
	      "<div data-src='#{@img_url}/generated/#{@year}/#{@directory}/#{@base}-1800x1800.#{@ext}' data-media='(min-width: 768px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-o-min-device-pixel-ratio: 3/2)'></div>"\
	      "<noscript>"\
	        "<img src='#{@img_url}/generated/#{@year}/#{@directory}/#{@base}640x640.#{@ext}' alt='#{@text}'>"\
	      "</noscript>"\
	    "</div>"\
	    "<span id='photo-caption'>#{@text} </span><span id='photo-copyright' style='display:none'>&copy;#{@year} M. Andrew Eick</span>"
	  end

	end
end

Liquid::Template.register_tag('photo3', Jekyll::Photo3)