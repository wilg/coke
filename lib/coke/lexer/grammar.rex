class Coke::Parser
macro
  BLANK         [\A ]+
rule
  BLANK         # no action
  \d+           { [:IDENTIFIER, text.to_i] }
  \A([a-z]\w*)  { [:IDENTIFIER, text] }
  \A"(.*?)"			{ [:STRING, text] }
  \n 	          { [:NEWLINE, text] }
  .             { [text, text] }
end
