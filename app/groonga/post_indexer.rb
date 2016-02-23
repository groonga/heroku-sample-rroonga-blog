class PostIndexer
  def initialize
    @posts = Groonga['Posts']
  end

  def add(post)
    return if @posts.nil?
    attributes = post.attributes
    id = attributes.delete('id')
    @posts.add(id, attributes)
  end

  def remove(post)
    return if @posts.nil?
    @posts[post.id].delete
  end
end
