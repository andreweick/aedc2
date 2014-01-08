# Title: Simple Video tag for Jekyll
# Author: Andrew Eick http://eick.us
# Description: Output tags for videojs with a check that the file exists first
#
# Syntax {% video url/to/video w/o extension [width height] [url/to/poster] %}
#
# Example:
# {% aedc-video http://site.com/video 720 480 http://site.com/poster-frame.jpg %}
#
#

require 'open-uri'
require 'net/http'


class AEDCVideoTag < Liquid::Tag
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
      @poster = $7 || @video + '-640x360.jpg'     # Default poster image is video name + size
    end
    super
  end

  def render(context)
    output = super
    if @video
      video =  "<script type='text/javascript' src='http://cdn.sublimevideo.net/js/gpbp4gog.js'></script>"
      video +=  "<video class='sublime' preload='none' poster='#{@poster}' data-name='#{@video}' data-uid='#{}' data-autoresize='fit'>"

      # Default size is 640x360
      if remote_file_exists(@video + '-640x360.mp4')
        video += "<source src='#{@video}-640x360.mp4' />"
      end

      # HD size is 1280x720
      if remote_file_exists(@video + '-1280x720.mp4')
        video += "<source src='#{@video}-1280x720.mp4' data-quality='hd'/>"
      end

      # mobile
      if remote_file_exists(@video + '-640x360-mobile.mp4')
        video += "<source src='#{@video}-640x360-mobile.mp4' />"
      end

      video += "</video>"
    else
      "Error processing input, expected syntax: {% video url/to/video [width height] [url/to/poster] %}"
    end
  end
end

Liquid::Template.register_tag('aedc_video', AEDCVideoTag)   # connect the tag name to the processing class

