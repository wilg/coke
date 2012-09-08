#!/usr/bin/env rake
require "bundler/gem_tasks"

task :dev do
	puts "Building..."
	# `bundle exec rex -o lib/coke/lexer/lexer.rb lib/coke/lexer/grammar.rex`
	`bundle exec racc -o lib/coke/parser/parser.rb lib/coke/parser/grammar.y`
end