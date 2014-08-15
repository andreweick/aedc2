# Title: Simple Photo tag for Jekyll
# Author: Andrew Eick http://eick.us
# Description: Output tags for photos specific to my web site and media storage.
#   * Assumptions
#     * Photographs are stored at a base url and will be
#   *Original*
#   1. base-url/images/original/2012/2012-01-14/(photograph)
#   *Generated*
#   1. base-url/images/generated/2012/1800/2012-01-14/(photograph)
#   2. base-url/images/generated/2012/320/2012-01-14/(photograph)
#   3. base-url/images/generated/2012/480/2012-01-14/(photograph)
#   4. base-url/images/generated/2012/500/2012-01-14/(photograph)
#   5. base-url/images/generated/2012/640/2012-01-14/(photograph)
#   6. base-url/images/generated/2012/768/2012-01-14/(photograph)
#   7. base-url/images/generated/2012/900/2012-01-14/(photograph)
#   8. base-url/images/generated/2012/960/2012-01-14/(photograph)
#   9. base-url/images/generated/2012/1536/2012-01-14/(photograph)
#  10. base-url/images/generated/2012/1800/2012-01-14/(photograph)
#
#
# Syntax {% photo url/to/original/photo "alternate text"%}
#
# Example:
#   {% photo http://media.eick.us/images/original/2012/2012-07-31/2012-07-28at10.34.28.jpg "Libby in pig tails" %}

require "erb"

module Jekyll
  class MyPhotoTag < Liquid::Tag
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

        postYear = context["page"]["date"].year

          # <picture>
          #   <source srcset="examples/images/extralarge.jpg" media="(min-width: 1000px)">
          #   <source srcset="examples/images/large.jpg" media="(min-width: 800px)">
          #   <img srcset="examples/images/medium.jpg" alt="A giant stone face at The Bayon temple in Angkor Thom, Cambodia">
          # </picture>

          # <div data-picture="" data-alt="#{@alt}, \u00A9 2013 Andrew Eick">
          #   <div data-src="http://media.eick.us/images/generated/<%= year %>/320/<%= directory %>/<%= filename %>"></div>
          #   <div data-src="http://media.eick.us/images/generated/<%= year %>/480/<%= directory %>/<%= filename %>" data-media="(min-width: 320px)"></div>
          #   <div data-src="http://media.eick.us/images/generated/<%= year %>/768/<%= directory %>/<%= filename %>" data-media="(min-width: 480px)"></div>
          #   <div data-src="http://media.eick.us/images/generated/<%= year %>/900/<%= directory %>/<%= filename %>" data-media="(min-width: 768px)"></div>
          #   <div data-src="http://media.eick.us/images/generated/<%= year %>/640/<%= directory %>/<%= filename %>" data-media="(-webkit-min-device-pixel-ratio: 1.5),(-moz-min-device-pixel-ratio: 1.5),(-o-min-device-pixel-ratio: 3/2)"></div>
          #   <div data-src="http://media.eick.us/images/generated/<%= year %>/960/<%= directory %>/<%= filename %>" data-media="(min-width: 320px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-o-min-device-pixel-ratio: 3/2)"></div>
          #   <div data-src="http://media.eick.us/images/generated/<%= year %>/1536/<%= directory %>/<%= filename %>" data-media="(min-width: 480px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-o-min-device-pixel-ratio: 3/2)"></div>
          #   <div data-src="http://media.eick.us/images/generated/<%= year %>/1800/<%= directory %>/<%= filename %>" data-media="(min-width: 768px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-o-min-device-pixel-ratio: 3/2)"></div>
          #   <noscript>
          #     <img src="http://media.eick.us/images/generated/<%= year %>/640/<%= directory %>/<%= filename %>" alt="#{@alt}, \u00A9 2013 Andrew Eick">
          #   </noscript>
          # </div>
          # <span id="photo-caption">#{@alt}</span><span id='photo-copyright'>\u00A9 #{postYear} M. Andrew Eick</span>
        picturefillDiv = ERB.new <<-PICTUREFILLTEMPLATE.gsub(/^ {10}/,'')
          <picture>
            <source srcset="http://192.168.1.14/media/<%= year %>/<%= directory %>/2560/<%= filename %>" media="(min-width: 1000px)">
            <source srcset="http://192.168.1.14/media/<%= year %>/<%= directory %>/1280/<%= filename %>" media="(min-width: 768px)">
            <source srcset="http://192.168.1.14/media/<%= year %>/<%= directory %>/640/<%= filename %>" media="(min-width: 480)">
            <img srcset="http://192.168.1.14/media/<%= year %>/<%= directory %>/320/<%= filename %>">
          </picture>
          PICTUREFILLTEMPLATE
        return picturefillDiv.result(binding)
      else
        raise "Error processing input, expected syntax: {% photo url/to/original/photo \"alternate text\" %}"
      end
    end

  end
end

Liquid::Template.register_tag('photo', Jekyll::MyPhotoTag)
