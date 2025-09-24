# frozen_string_literal: true

task default: :run

task :run do
  ruby 'main.rb'
end

task :setup do
  sh 'bundle install --path=vendor/bundle'
end

namespace :lint do
  task :check do
    sh 'bundle exec rubocop'
  end

  task :fix do
    sh 'bundle exec rubocop -A'
  end
end
