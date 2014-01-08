require 'open-uri'
require 'net/http'

class Video < Liquid::Tag
  @video_player = "sublime"
  @video = nil
  @poster = ''
  @height = ''
  @width = ''

  def remote_file_exists(url)
    url = URI.parse(url)
    Net::HTTP.start(url.host, url.port) do |http|
    return http.head(url.request_uri).code == "200"
    end
  end

  def initialize(tag_name, markup, tokens)
    if markup =~ /((https?:\/\/|\/)(\S+))(\s+(\d+)\s(\d+))?(\s+(https?:\/\/|\/)(\S+))?/i
      @video  = $1
      @width  = $5
      @height = $6
      @poster = $7
    end
    super
  end

  def render(context)
    @video_player = "sublime"
    output = super
    if @video
      if @video_player == "sublime"
        video =  "<script type='text/javascript' src='http://cdn.sublimevideo.net/js/gpbp4gog.js'></script>"

        video +=  "<video class='sublime' preload='none' controls poster='#{@poster}' data-setup='{}' data-autoresize='fit'>"
      else
        # Default to videojs (opensource)
        video =  "<link href='http://vjs.zencdn.net/c/video-js.css' rel='stylesheet'>"
    video += "<script src='http://vjs.zencdn.net/c/video.js'></script>"

        video +=  "<video class='video-js vjs-default-skin' width='#{@width}' height='#{@height}' preload='none' controls poster='#{@poster}' data-setup='{}'>"
      end


      if remote_file_exists(@video + '.m3u8')
        video += "<source src='#{@video}.m3u8' type='application/x-mpegURL'/>"
      end

      if remote_file_exists(@video + '.mp4')
        video += "<source src='#{@video}.mp4' type='video/mp4'/>"
      end

      if remote_file_exists(@video + '.mov')
        video += "<source src='#{@video}.mov' type='video/mp4'/>"
      end

      if remote_file_exists(@video + '.webm')
        video += "<source src='#{@video}.webm' type='video/webm'/>"
      end

      if remote_file_exists(@video + '.ogv')
        video += "<source src='#{@video}.ogv' type='video/ogg'/>"
    end

      video += "</video>"
    else
      "Error processing input, expected syntax: {% video url/to/video [width height] [url/to/poster] %}"
    end
  end
end

Liquid::Template.register_tag('video', Video)
