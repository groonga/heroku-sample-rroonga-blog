module PostsHelper
  def highlight(text)
    if @highlighter
      raw(@highlighter.highlight(text))
    else
      text
    end
  end
end
