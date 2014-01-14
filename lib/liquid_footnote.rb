class FootnoteLink < Liquid::Tag
  def initialize(tag_name, number, tokens)
    @number = number
    super
  end

  def render(context)
    "<sup id='fnref:#{@number}'><a href='#fn:#{@number}' rel='footnote'>#{@number}</a></sup>"
  end
end
Liquid::Template.register_tag('footnote_link', FootnoteLink)




class Footnote < Liquid::Block
  def initialize(tag_name, markup, tokens)
    @number = markup.to_i
    super
  end

  def render(context)
    number = @number
    footnote = paragraphize(super)
    "<li class='footnote' id='fn:#{number}'>#{footnote}</li>"
  end

  def paragraphize(input)
    "<p>#{input.lstrip.rstrip.gsub(/\n\n/, '</p><p>').gsub(/\n/, '<br/>')}</p>"
  end
end
Liquid::Template.register_tag('footnote', Footnote)




class FootnotesList < Liquid::Block
  def initialize(tag_name, markup, tokens)
    @number = $1
    super
  end

  def render(context)
    "<div class='footnotes'><ol>#{super}</ol></div>"
  end
end
Liquid::Template.register_tag('footnotes', FootnotesList)
