module PostHelpers

  def vimeo(video_id)
    "<div class='video'><iframe src='//player.vimeo.com/video/#{video_id}' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></div>"
  end

  def simple_date(date)
    date.strftime("%b #{date.strftime('%e').to_i.ordinalize}, %Y")
  end

end
