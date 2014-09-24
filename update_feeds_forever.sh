#!/usr/bin/env bash

while true; do
  bundle exec ruby ./update_feeds.rb
  sleep 600
done
