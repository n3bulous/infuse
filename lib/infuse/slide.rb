class Slide
  def initialize(title, content_lines)
    @title = title
    @content = content_lines.to_s
    @notes = ""
  end

  def notes(content)
    @notes = content.to_s
  end

  def convert(slide_template, markup_lang="textile")
    RedCloth.new(ERB.new(slide_template, 0, ">").result(self.send(:binding))).to_html
  end
end
