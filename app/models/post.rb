class Post < ActiveRecord::Base
  after_save do |post|
    indexer = PostIndexer.new
    indexer.add(post)
  end

  after_destroy do |post|
    indexer = PostIndexer.new
    indexer.remove(post)
  end
end
