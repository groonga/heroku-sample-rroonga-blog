require_relative '../config/environment'

require 'fileutils'
require 'groonga'

database_path = ENV['GROONGA_DATABASE_PATH'] || 'groonga/database'
if File.exist?(database_path)
  Groonga::Database.open(database_path)
else
  Groonga::Database.create(path: database_path)
end

Groonga::Schema.define do |schema|
  schema.create_table('Posts',
                      type: :hash,
                      key_type: :uint32) do |table|
    table.short_text('title')
    table.text('content')
    table.time('created_at')
    table.time('updated_at')
  end
end

posts = Groonga['Posts']
Post.all.each do |post|
  attributes = post.attributes
  id = attributes.delete("id")
  posts.add(id, attributes)
end

Groonga::Schema.define do |schema|
  schema.create_table('Terms',
                      type: :patricia_trie,
                      key_type: :short_text,
                      normalizer: 'NormalizerAuto',
                      default_tokenizer: 'TokenBigram') do |table|
    table.index('Posts.title')
    table.index('Posts.content')
  end

  schema.create_table('Times',
                      type: :patricia_trie,
                      key_type: :time) do |table|
    table.index('Posts.created_at')
    table.index('Posts.updated_at')
  end
end
