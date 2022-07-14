#!/bin/bash
bundle exec rails db:migrate
bundle exec rails assets:precompile
bundle exec rake dummies:user
bundle exec rake dummies:categories
bundle exec rake dummies:products
