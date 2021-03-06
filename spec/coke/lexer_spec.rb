require 'spec_helper'

describe Coke::Lexer do

	let(:lexer) { Coke::Lexer.new }
	def lexed code
		lexer.tokenize code
	end
	def lexedf filename
    open(File.expand_path(File.join(__FILE__, "..", "..", "fixtures", filename)), "r") do |f|
      lexer.tokenize f.read
    end
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

	describe "helloworld.coke" do

		let(:l){lexedf "helloworld.coke"}

		it "lexes right" do
			l.should == [
				[:COMMENT, " Comment"],
				[:NEWLINE, "\n"],
				[:IDENTIFIER, "log"],
				[:STRING, "hello world"]
			]
		end

	end

	it "lexes spaces to whitespace" do
		lexed("  identifier").should == [[:IDENTIFIER, "identifier"]]
	end

	it "lexes tabs to whitespace" do
		# # lexed("\t\tidentifier").should == [[:IDENTIFIER, "identifier"]]
	end

	describe "lexes method calls" do

		it "lexes methods with parentheses" do
			lexed("NSBundle.mainBundle()").should == [
				[:CONSTANT, "NSBundle"],
				[".", "."],
				[:IDENTIFIER, "mainBundle"],
				["(", "("],
				[")", ")"]
			]
		end

		it "lexes methods with a colon in the name" do
			lexed("NSBundle.mainBundle:()").should == [
				[:CONSTANT, "NSBundle"],
				[".", "."],
				[:IDENTIFIER, "mainBundle"],
				[":", ":"],
				["(", "("],
				[")", ")"]
			]
		end

		it "lexes methods with no argument argument without parentheses" do
			lexed('NSBundle.mainBundle.loadNibNamed: "ChallengePromoCell" owner:@ options:nil').should == [
				[:CONSTANT, "NSBundle"],
				[".", "."],
				[:IDENTIFIER, "mainBundle"],
				[".", "."],
				[:IDENTIFIER, "loadNibNamed"],
				[":", ":"],
				[:STRING, "ChallengePromoCell"],
				[:IDENTIFIER, "owner"],
				[":", ":"],
				["@", "@"],
				[:IDENTIFIER, "options"],
				[":", ":"],
				[:NIL, "nil"]
			]
		end

		it "lexes methods with no argument argument without parentheses" do
			lexed('NSBundle.mainBundle.loadNibNamed:("ChallengePromoCell" owner:@ options:nil)').should == [
				[:CONSTANT, "NSBundle"],
				[".", "."],
				[:IDENTIFIER, "mainBundle"],
				[".", "."],
				[:IDENTIFIER, "loadNibNamed"],
				[":", ":"],
				["(", "("],
				[:STRING, "ChallengePromoCell"],
				[:IDENTIFIER, "owner"],
				[":", ":"],
				["@", "@"],
				[:IDENTIFIER, "options"],
				[":", ":"],
				[:NIL, "nil"],
				[")", ")"]
			]
		end

	end

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
