module Jekyll
	class Vimeo < Liquid::Tag
	  def initialize(tag_name, video_id, tokens)
	    super
	    @video_id = video_id
	  end

	  def render(context)
	    "<figure><div class='video'><iframe src='//player.vimeo.com/video/#{@video_id}' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></div></figure>"
	  end
	end
end

Liquid::Template.register_tag('video', Jekyll::Vimeo)