# A sample blog application for Rroonga on Heroku

This is a sample blog application to show how to use Rroonga on
Heroku.

## Demonstration

See http://rroonga-blog.herokuapp.com/ .

Note that the demonstration site may be deleted.

## Install

    % git clone https://github.com/groonga/heroku-sample-rroonga-blog.git
    % cd heroku-sample-rroonga-blog
    % heroku apps:create --addons heroku-postgresql --buildpack https://codon-buildpacks.s3.amazonaws.com/buildpacks/groonga/groonga.tgz
    % heroku buildpacks:add heroku/ruby
    % heroku buildpacks:add https://codon-buildpacks.s3.amazonaws.com/buildpacks/groonga/rroonga.tgz
    % git push heroku master
    % heroku run rake db:migrate
    % heroku apps:open

You can search blog posts by title and content in the search form.

You can posts test entries:

    % bundle install
    % env $(heroku apps:info --shell | grep '^web-url=' | sed -e 's/^web-url=/web_url=/') bin/rails import

You can select test entries. For example, the following command just
posts Ruby news in Japanese:

    % env $(heroku apps:info --shell | grep '^web-url=' | sed -e 's/^web-url=/web_url=/') bin/rails import:ruby:ja

## License

CC0 1.0 Universal (Public Domain)

## Thanks

  * mallowlabs: Web design.
