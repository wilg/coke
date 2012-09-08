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

end
