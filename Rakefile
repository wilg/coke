#!/usr/bin/env rake
require "bundler/gem_tasks"

task :dev do
	puts "Building..."
	# `bundle exec rex -o lib/coke/lexer/lexer.rb lib/coke/lexer/grammar.rex`
	`bundle exec racc -o lib/coke/parser/parser.rb lib/coke/parser/grammar.y`
end

# Travis!
require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'

desc "Run RSpec"
RSpec::Core::RakeTask.new do |t|
  t.verbose = false
end

task :default => :spec