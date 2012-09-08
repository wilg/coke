class Coke::Parser
macro
  BLANK         [\ \t]+
rule
  BLANK         # no action
  \d+           { [:IDENTIFIER, text.to_i] }
  \w+           { [:IDENTIFIER, text] }
  \n
  .             { [text, text] }
end
