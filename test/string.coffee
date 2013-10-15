require "../string"

ok = assert
equals = assert.equal
test = it

describe "String", ->
  
  test "#blank", ->
    equals "  ".blank(), true, "A string containing only whitespace should be blank"
    equals "a".blank(), false, "A string that contains a letter should not be blank"
    equals "  a ".blank(), false
    equals "  \n\t ".blank(), true
  
  test "#extension", ->
    equals "README".extension(), ""
    equals "README.md".extension(), "md"
    equals "jquery.min.js".extension(), "js"
    equals "src/bouse.js.coffee".extension(), "coffee"
  
  test "#parse", ->
    equals "true".parse(), true, "parsing 'true' should equal boolean true"
    equals "false".parse(), false, "parsing 'true' should equal boolean true"
    equals "7.2".parse(), 7.2, "numbers should be cool too"
  
    equals '{"val": "a string"}'.parse().val, "a string", "even parsing objects works"
  
    ok ''.parse() == '', "Empty string parses to exactly the empty string"
  
  test "#startsWith", ->
    ok "cool".startsWith("coo")
    equals "cool".startsWith("oo"), false
  
  test "#toInt", ->
    equals "31.3".toInt(), 31
    equals "31.".toInt(), 31
    equals "-1.02".toInt(), -1
  
    equals "009".toInt(), 9
    equals "0109".toInt(), 109
  
    equals "F".toInt(16), 15
  
  test "#withoutExtension", ->
    equals "neat.png".withoutExtension(), "neat"
    equals "not a file".withoutExtension(), "not a file"
