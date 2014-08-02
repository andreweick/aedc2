# Title: Simple Photo tag for Jekyll
# Author: Andrew Eick http://eick.us
# Description: Output tags for photos specific to my web site and media storage.
#   * Assumptions
#     * Photographs are stored at a base url and will be
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
#
#
# Syntax {% photo url/to/original/photo "alternate text"%}
#
# Example:
#   {% photo http://media.eick.us/images/original/2012/2012-07-31/2012-07-28at10.34.28.jpg "Libby in pig tails" %}

require "erb"

module Jekyll
  class MyPhotoTag2 < Liquid::Tag
    @photo = nil

    def initialize(tag_name, markup, tokens)
      if markup =~ /((https?:\/\/|\/)(\S+))(\s+(\d+)\s(\d+))?(\s+(https?:\/\/|\/)(\S+))? (".*")/i
        @photo  = $1
        @alt = $10.gsub /\"(.*)\"/, '\1'     # Delete the quotes using regex

        #I've got no idea why this is #10, found in the 'match groups' at http://rubular.com/
      end

      super
    end

    def render(context)
      if @photo
        year = @photo.split("/")[-3]
        directory = @photo.split("/")[-2]
        filename = @photo.split("/")[-1]

        default_copyright = "\u00A9 #{context["page"]["date"].year} M. Andrew Eick"

        photographs = context["page"]["photographs"]
        if photographs == nil
          photo_metadata = "\u00A9 M. Andrew Eick"
        else
          p = photographs.find { |p| p["url"] == @photo }
          photo_metadata = "#{p['exposure_time']} at <i>F</i>/#{p['aperture']} ISO #{p['iso']}, #{p['copyright']}"
        end

        picturefillDiv = ERB.new <<-PICTUREFILLTEMPLATE.gsub(/^ {10}/,'')
          <div data-picture="" data-alt="#{@alt}">
            <div data-src="http://media.eick.us/images/generated/<%= year %>/<%= directory %>/320/<%= filename %>"></div>
            <div data-src="http://media.eick.us/images/generated/<%= year %>/<%= directory %>/480/<%= filename %>" data-media="(min-width: 320px)"></div>
            <div data-src="http://media.eick.us/images/generated/<%= year %>/<%= directory %>/768/<%= filename %>" data-media="(min-width: 480px)"></div>
            <div data-src="http://media.eick.us/images/generated/<%= year %>/<%= directory %>/900/<%= filename %>" data-media="(min-width: 768px)"></div>
            <div data-src="http://media.eick.us/images/generated/<%= year %>/<%= directory %>/640/<%= filename %>" data-media="(-webkit-min-device-pixel-ratio: 1.5),(-moz-min-device-pixel-ratio: 1.5),(-o-min-device-pixel-ratio: 3/2)"></div>
            <div data-src="http://media.eick.us/images/generated/<%= year %>/<%= directory %>/960/<%= filename %>" data-media="(min-width: 320px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-o-min-device-pixel-ratio: 3/2)"></div>
            <div data-src="http://media.eick.us/images/generated/<%= year %>/<%= directory %>/1536/<%= filename %>" data-media="(min-width: 480px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-o-min-device-pixel-ratio: 3/2)"></div>
            <div data-src="http://media.eick.us/images/generated/<%= year %>/<%= directory %>/1800/<%= filename %>" data-media="(min-width: 768px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-o-min-device-pixel-ratio: 3/2)"></div>
            <noscript>
              <img src="http://media.eick.us/images/generated/<%= year %>/<%= directory %>/640/<%= filename %>" alt="#{@alt}">
            </noscript>
          </div>
          <span id="photo-caption">#{@alt}</span><span id='photo-copyright'>#{photo_metadata}</span>
          PICTUREFILLTEMPLATE
        return picturefillDiv.result(binding)
      else
        "Error processing input, expected syntax: {% photo url/to/original/photo \"alternate text\" %}"
      end
    end

  end
end

Liquid::Template.register_tag('photo2', Jekyll::MyPhotoTag2)
