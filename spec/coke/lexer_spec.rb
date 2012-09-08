require 'spec_helper'

describe Coke::Lexer do

	let(:lexer) { Coke::Lexer.new }
	def lexed code
		lexer.tokenize code
	end

	# REX LEXING
	# def lex str
	# 	@scanner = Coke::Parser.new
	# 	@scanner.scan_setup str
	# end

	# def lexed(scanner = @scanner)
	# 	tokens = []
	# 	while token = scanner.next_token
	# 		tokens << token
	# 	end
	# 	tokens
	# end

	describe "lexes methods" do

		it "with string param" do
			lexed('log "hello world"').should == [[:IDENTIFIER, "log"], [:STRING, "hello world"]]
		end

		it "in parentheses with string param" do
			lexed('log("hello world")').should == [[:IDENTIFIER, "log"], ["(", "("], [:STRING, "hello world"], [")", ")"]]
		end

		it "with number param" do
			lexed('log 2').should == [[:IDENTIFIER, "log"], [:NUMBER, 2]]
		end

	end

	it "identifies methods" do
    code = <<-CODE
def method:
  true
CODE
    lexed(code).should == [[:DEF, "def"], [:IDENTIFIER, "method"], [:INDENT, 2], [:TRUE, "true"], [:DEDENT, 0]]
  end


end
