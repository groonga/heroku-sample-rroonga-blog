class PostSearcher
  def initialize(query)
    @query = query
    @posts = Groonga['Posts']
  end

  def search
    matched_posts = @posts.select do |record|
      (record.title =~ @query) | (record.content =~ @query)
    end
    post_ids = matched_posts.sort(['_score']).collect do |matched_post|
      matched_post._key
    end
    Post.where(id: post_ids)
  end
end
