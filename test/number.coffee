require "../number"

ok = assert
equals = assert.equal
test = it

equalEnough = (expected, actual, tolerance, message) ->
  message ||= "#{expected} within #{tolerance} of #{actual}"

  ok(expected + tolerance >= actual && expected - tolerance <= actual, message)
  
describe "Number", ->
  
  test "#abs", ->
    equals 5.abs(), 5, "(5).abs() equals 5"
    equals 4.2.abs(), 4.2, "(4.2).abs() equals 4.2"
    equals (-1.2).abs(), 1.2, "(-1.2).abs() equals 1.2"
    equals 0.abs(), 0, "(0).abs() equals 0"
  
  test "#ceil", ->
    equals 4.9.ceil(), 5, "(4.9).floor() equals 5"
    equals 4.2.ceil(), 5, "(4.2).ceil() equals 5"
    equals (-1.2).ceil(), -1, "(-1.2).ceil() equals -1"
    equals 3.ceil(), 3, "(3).ceil() equals 3"
  
  test "#clamp", ->
    equals 5.clamp(0, 3), 3
    equals 5.clamp(-1, 0), 0
    equals (-5).clamp(0, 1), 0
    equals 1.clamp(0, null), 1
    equals (-1).clamp(0, null), 0
    equals (-10).clamp(-5, 0), -5
    equals (-10).clamp(null, 0), -10
    equals 50.clamp(null, 10), 10
  
  test "#floor", ->
    equals 4.9.floor(), 4, "(4.9).floor() equals 4"
    equals 4.2.floor(), 4, "(4.2).floor() equals 4"
    equals (-1.2).floor(), -2, "(-1.2).floor() equals -2"
    equals 3.floor(), 3, "(3).floor() equals 3"
  
  test "#round", ->
    equals 4.5.round(), 5, "(4.5).round() equals 5"
    equals 4.4.round(), 4, "(4.4).round() equals 4"
  
  test "#sign", ->
    equals 5.sign(), 1, "Positive number's sign is 1"
    equals (-3).sign(), -1, "Negative number's sign is -1"
    equals 0.sign(), 0, "Zero's sign is 0"
  
  test "#even", ->
    [0, 2, -32].each (n) ->
      ok n.even(), "#{n} is even"
  
    [1, -1, 2.2, -3.784].each (n) ->
      equals n.even(), false, "#{n} is not even"
  
  test "#odd", ->
    [1, 9, -37].each (n) ->
      ok n.odd(), "#{n} is odd"
  
    [0, 32, 2.2, -1.1].each (n) ->
      equals n.odd(), false, "#{n} is not odd"
  
  test "#times", ->
    n = 5
    equals n.times(->), n, "returns n"
  
  test "#times called correct amount", ->
    n = 5
    count = 0
  
    n.times -> count++
  
    equals n, count, "returns n"
  
  test "#mod should have a positive result when used with a positive base and a negative number", ->
    n = -3
  
    equals n.mod(8), 5, "Should 'wrap' and be positive."
  
  test "#degrees", ->
    equals 180.degrees, Math.PI
    equals 1.degree, Math.TAU / 360
  
  test "#rotations", ->
    equals 1.rotation, Math.TAU
    equals 0.5.rotations, Math.TAU / 2
  
  test "#turns", ->
    equals 1.turn, Math.TAU
    equals 0.5.turns, Math.TAU / 2
