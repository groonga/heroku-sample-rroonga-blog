require 'rss'
require 'mechanize'

def import_rss(url)
  uri = URI(ENV['APP_URL'])
  uri.path = '/posts/new'
  agent = Mechanize.new

  rss = RSS::Parser.parse(url)
  rss.items.each do |item|
    new_post_page = agent.get(uri.to_s)
    form = new_post_page.forms.first
    form['post[title]']   = item.title
    form['post[content]'] = item.description
    form.submit
  end
end

namespace :import do
  task prepare: :environment do
    if ENV['APP_URL'].nil?
      message = <<-MESSAGE
Must set APP_URL environment variable
e.g.: rake import APP_URL=http://localhost:3000
      MESSAGE
      raise message
    end
  end

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
  task blogroonga: ['import:blogroonga:en', 'import:blogroonga:ja']

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
  task ruby: ['import:ruby:en', 'import:ruby:ja']
end

desc 'Import entries'
task import: ['import:blogroonga', 'import:ruby']
