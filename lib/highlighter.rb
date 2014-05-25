class Highlighter
  def initialize(keywords)
    @patricia_trie = Groonga::PatriciaTrie.create(key_type: "ShortText",
                                                  normalizer: "NormalizerAuto")
    keywords.each do |word|
      @patricia_trie.add(word)
    end
  end

  def highlight(text)
    other_text_handler = lambda do |string|
      ERB::Util.html_escape(string)
    end
    options = {
      other_text_handler: other_text_handler,
    }
    highlighted_text = @patricia_trie.tag_keys(text, options) do |record, word|
      "<span class=\"keyword\">#{ERB::Util.html_escape(word)}</span>"
    end
    highlighted_text.html_safe
  end
end
