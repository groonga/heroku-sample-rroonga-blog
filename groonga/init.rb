require_relative '../config/environment'

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

if Post.table_exists?
  indexer = PostIndexer.new
  Post.all.each do |post|
    indexer.add(post)
  end
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

  schema.create_table('Words',
                      type: :patricia_trie,
                      key_type: :short_text,
                      normalizer: 'NormalizerAuto',
                      default_tokenizer: 'TokenMecab') do |table|
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
