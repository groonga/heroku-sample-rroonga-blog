class PostIndexer
  def initialize
    @posts = Groonga['Posts']
  end

  def add(post)
    attributes = post.attributes
    id = attributes.delete('id')
    @posts.add(id, attributes)
  end

  def remove(post)
    @posts[post.id].delete
  end
end
