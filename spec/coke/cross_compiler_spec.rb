require 'spec_helper'

describe Coke::CrossCompiler do

	let(:cross_compiler) { Coke::CrossCompiler.new }
	def compiled code
		cross_compiler.compile code
	end

	describe "compiles method calls" do

		it "with string param" do
			compiled('method("hello", "world")').should == "[self method]"
		end

		it "with parentheses" do
			compiled("NSBundle.mainBundle()").should == "[NSBundle mainBundle]"
		end

		it "nested with parentheses" do
			compiled("NSBundle.alloc().init()").should == "[[NSBundle alloc] init]"
		end

		it "nested without parentheses" do
			compiled("NSBundle.alloc.init").should == "[[NSBundle alloc] init]"
		end

		it "with a colon in the name" do
			compiled("NSBundle.alloc:()").should == "[NSBundle alloc]"
		end

		it "with named arguments" do
			compiled('NSBundle.mainBundle.loadNibNamed(:"ChallengePromoCell" owner:@ options:nil)').should ==
			'[[NSBundle mainBundle] loadNibNamed:@"ChallengePromoCell" owner:self options:nil]'
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
