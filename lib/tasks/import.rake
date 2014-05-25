require 'rss'

def import_rss(url)
  rss = RSS::Parser.parse(url)
  rss.items.each do |item|
    Post.create(title:   item.title,
                content: item.description)
  end
end

namespace :import do
  task prepare: :environment

  namespace :blogroonga do
    desc 'Import blogroonga entries in English'
    task en: 'import:prepare' do
      import_rss('http://groonga.org/blog/index.rdf')
    end

    desc 'Import blogroonga entries in Japanese'
    task ja: 'import:prepare' do
      import_rss('http://groonga.org/ja/blog/index.rdf')
    end
  end

  desc 'Import blogroonga entries'
  task :blogroonga => ['import:blogroonga:en', 'import:blogroonga:ja']

  namespace :ruby do
    desc 'Import Ruby news in English'
    task en: 'import:prepare' do
      import_rss('https://www.ruby-lang.org/en/feeds/news.rss')
    end

    desc 'Import Ruby news in Japanese'
    task ja: 'import:prepare' do
      import_rss('https://www.ruby-lang.org/ja/feeds/news.rss')
    end
  end

  desc 'Import Ruby news'
  task :ruby => ['import:ruby:en', 'import:ruby:ja']
end
