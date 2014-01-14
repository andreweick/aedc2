class FootnoteLink < Liquid::Tag
  def initialize(tag_name, args, tokens)
    super
    @number = args
  end

  def render(context)
    "<sup id='fnref:#{@number}'><a href='#fn:#{@number}' rel='footnote'>#{@number}</a></sup>"
  end
end

Liquid::Template.register_tag('footnote', FootnoteLink)




class Footnote < Liquid::Block
  def initialize(tag_name, markup, tokens)
    @by = nil
    @source = nil
    @title = nil
    if markup =~ FullCiteWithTitle
      @by = $1
      @source = $2 + $3
      @title = $4.titlecase.strip
    elsif markup =~ FullCite
      @by = $1
      @source = $2 + $3
    elsif markup =~ AuthorTitle
      @by = $1
      @title = $2.titlecase.strip
    elsif markup =~ Author
      @by = $1
    end
    super
  end

  def render(context)
    quote = paragraphize(super)
    author = "- #{@by.strip}" if @by
    if @source
      url = @source.match(/https?:\/\/(.+)/)[1].split('/')
      parts = []
      url.each do |part|
        if (parts + [part]).join('/').length < 32
          parts << part
        end
      end
      source = parts.join('/')
      source << '/&hellip;' unless source == @source
    end
    if !@source.nil?
      cite = " <cite><a href='#{@source}'>#{(@title || source)}</a></cite>"
    elsif !@title.nil?
      cite = " <cite>#{@title}</cite>"
    end
    blockquote = if @by.nil?
      quote
    elsif cite
      "#{quote}<footer>#{author + cite}</footer>"
    else
      "#{quote}<footer>#{author}</footer>"
    end
    "<blockquote>#{blockquote}</blockquote>"
  end

  def paragraphize(input)
    "<p>#{input.lstrip.rstrip.gsub(/\n\n/, '</p><p>').gsub(/\n/, '<br/>')}</p>"
  end
end

Liquid::Template.register_tag('blockquote', Blockquote)
