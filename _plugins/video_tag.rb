module Jekyll
  class Vimeo < Liquid::Tag
    def initialize(tag_name, video_id, tokens)
      super
      @video_id = video_id
    end

    def render(context)
      picturefillDiv = ERB.new <<-VIDEOJSTEMPLATE.gsub(/^ {8}/,'')
        <video 
          id="vid1" 
          src="" 
          class="video-js vjs-default-skin" controls preload="auto" 
          width="640" height="360" 
          data-setup='{ "techOrder": ["vimeo"], "src": "https://vimeo.com/<%= @video_id %>", "loop": true, "autoplay": false }'
        >
          <p>Video Playback Not Supported</p>
        </video>
      VIDEOJSTEMPLATE
      return picturefillDiv.result(binding)
    end
  end
end

Liquid::Template.register_tag('video', Jekyll::Vimeo)