module PostHelpers

  def vimeo(video_id)
    "<div class='video'><iframe src='//player.vimeo.com/video/#{video_id}' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></div>"
  end

end
