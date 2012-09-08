require 'spec_helper'

describe Coke::CrossCompiler do

	let(:cross_compiler) { Coke::CrossCompiler.new }
	def compiled code
		cross_compiler.compile code
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

	describe "compiles methods" do

		it "with string param" do
			compiled('method("hello", "world")').should == "[self method]"
		end

	end

# 	it "compiles method declarations" do
# 		code = <<-CODE
# def method:
#   x.method
# CODE
# 		compiled(code).should == "-(id)method{return YES;}"
# 	end

end
