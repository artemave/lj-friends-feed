FROM ruby
ENV RACK_ENV production
CMD bundle exec ruby ./update_feeds.rb
