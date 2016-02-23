class PostSearcher
  def initialize(query)
    @query = query
    @posts = Groonga['Posts']
  end

  def search
    matched_posts = @posts.select do |record|
      match_target = record.match_target do |match_record|
        (match_record.index('Words.Posts_title') * 10) |
          (match_record.index('Terms.Posts_title') * 8) |
          (match_record.index('Words.Posts_content') * 3) |
          (match_record.index('Terms.Posts_content'))
      end
      words.collect do |word|
        match_target =~ word
      end
    end
    post_ids = matched_posts.sort(['_score']).collect do |matched_post|
      matched_post._key
    end
    Post.where(id: post_ids)
  end

  def highlighter
    @highlighter ||= Highlighter.new(words)
  end

  private
  def words
    @query.split(/\s+/)
  end
end
