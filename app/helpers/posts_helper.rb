module PostsHelper
  def highlight(text)
    if @highlighter
      @highlighter.highlight(text)
    else
      text
    end
  end
end
