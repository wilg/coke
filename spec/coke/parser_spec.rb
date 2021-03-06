require 'spec_helper'

describe Coke::Parser do

	let(:parser) { Coke::Parser.new }
	def parsed code
		parser.parse code
	end

	it "identifies basic numbers" do
		parsed("1").should == Coke::Nodes.new([Coke::NumberNode.new(1)])
	end

	it "identifies basic methods" do
		parsed("method").should == Coke::Nodes.new([Coke::CallNode.new(nil, "method", [])])
	end

	it "identifies basic methods" do
		parsed('method("hello", "world")').should == Coke::Nodes.new([
			Coke::CallNode.new(nil, "method", [Coke::StringNode.new("hello"), Coke::StringNode.new("world")])
			])
	end

	it "parses methods with parentheses" do
		parsed("NSBundle.mainBundle()").should == Coke::Nodes.new([
			Coke::CallNode.new(Coke::GetConstantNode.new("NSBundle"), "mainBundle", [])
		])
	end

	it "identifies methods" do
    code = <<-CODE
def method:
  true
CODE
    nodes = Coke::Nodes.new([
      Coke::DefNode.new("method", [],
        Coke::Nodes.new([Coke::TrueNode.new])
      )
    ])
    parsed(code).should == nodes
  end

end
