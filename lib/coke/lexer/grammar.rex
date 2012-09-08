class Sample
macro
  BLANK         [\ \t]+
rule
  BLANK         # no action
  \d+           { [:digit, text.to_i] }
  \w+           { [:word, text] }
  \n
  .             { [text, text] }
end
