require 'spec_helper'

describe "Lexer" do

	def lex str
		@scanner = Coke::Parser.new
		@scanner.scan_setup str
	end

	def lexed(scanner = @scanner)
    tokens = []
    while token = scanner.next_token
      tokens << token
    end
    tokens
  end

	it "works" do
		lex <<-CODE
if 1:
  if 2:
    print "..."
    if false:
      pass
    print "done!"
  2

print "The End"
CODE
    tokens = [
      [:IF, "if"], [:NUMBER, 1],
        [:INDENT, 2],
          [:IF, "if"], [:NUMBER, 2],
          [:INDENT, 4],
            [:IDENTIFIER, "print"], [:STRING, "..."], [:NEWLINE, "\n"],
            [:IF, "if"], [:FALSE, "false"],
            [:INDENT, 6],
              [:IDENTIFIER, "pass"],
            [:DEDENT, 4], [:NEWLINE, "\n"],
            [:IDENTIFIER, "print"], [:STRING, "done!"],
        [:DEDENT, 2], [:NEWLINE, "\n"],
        [:NUMBER, 2],
      [:DEDENT, 0], [:NEWLINE, "\n"],
      [:NEWLINE, "\n"],
      [:IDENTIFIER, "print"], [:STRING, "The End"]
    ]
		lexed.should == tokens
	end

end
