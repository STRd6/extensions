Number
======

Returns the absolute value of this number.

>     #! example
>     (-4).abs()

Returns the mathematical ceiling of this number. The number truncated to the
nearest integer of greater than or equal value.

>     #! example
>     4.2.ceil()

---

>     #! example
>     (-1.2).ceil()

---

Returns the mathematical floor of this number. The number truncated to the
nearest integer of less than or equal value.

>     #! example
>     4.9.floor()

---

>     #! example
>     (-1.2).floor()

---

Returns this number rounded to the nearest integer.

>     #! example
>     4.5.round()

---

>     #! example
>     4.4.round()

---

    [
      "abs"
      "ceil"
      "floor"
      "round"
    ].forEach (method) ->
      Number::[method] = ->
        if isNaN(this)
          throw "Can't #{method} NaN"
        else
          Math[method](this)

    {extend} = require "./util"

    extend Number.prototype,

Get a bunch of points equally spaced around the unit circle.

      circularPoints: ->
        n = this

        [0..n].map (i) ->
          Point.fromAngle (i/n).turns

>     #! example
>     4.circularPoints()

---

Returns a number whose value is limited to the given range.

      clamp: (min, max) ->
        if min? and max?
          Math.min(Math.max(this, min), max)
        else if min?
          Math.max(this, min)
        else if max?
          Math.min(this, max)
        else
          this

>     #! example
>     512.clamp(0, 255)

---

A mod method useful for array wrapping. The range of the function is
constrained to remain in bounds of array indices.

      mod: (base) ->
        if isNaN(this)
          throw "Can't mod NaN"

        result = this % base

        if result < 0 && base > 0
          result += base

        return result

>     #! example
>     (-1).mod(5)

---

Get the sign of this number as an integer (1, -1, or 0).

      sign: ->
        if this > 0
          1
        else if this < 0
          -1
        else if isNaN(this)
          throw "Can't get sign of NaN"
        else
          0

>     #! example
>     5.sign()

---

Returns true if this number is even (evenly divisible by 2).

      even: ->
        @mod(2) is 0

>     #! example
>     2.even()

---

Returns true if this number is odd (has remainder of 1 when divided by 2).

      odd: ->
        @mod(2) is 1

>     #! example
>     3.odd()

---

Calls iterator the specified number of times, passing in the number of the
current iteration as a parameter: 0 on first call, 1 on the second call, etc.

      times: (iterator, context) ->
        i = -1

        while ++i < this
          iterator.call context, i

        return i

>     #! example
>     output = []
>
>     5.times (n) ->
>       output.push(n)
>
>     output

---

Returns the the nearest grid resolution less than or equal to the number.

      snap: (resolution) ->
        (n / resolution).floor() * resolution

>     #! example
>     7.snap(8)

---

      truncate: ->
        if this > 0
          @floor()
        else if this < 0
          @ceil()
        else
          this

Convert a number to an amount of rotations.

    unless 5.rotations
      Object.defineProperty Number::, 'rotations',
        get: ->
          this * Math.TAU

    unless 1.rotation
      Object.defineProperty Number::, 'rotation',
        get: ->
          this * Math.TAU

>     #! example
>     0.5.rotations

---

Convert a number to an amount of rotations.

    unless 5.turns
      Object.defineProperty Number.prototype, 'turns',
        get: ->
          this * Math.TAU

    unless 1.turn
      Object.defineProperty Number.prototype, 'turn',
        get: ->
          this * Math.TAU

>     #! example
>     0.5.turns

---

Convert a number to an amount of degrees.

    unless 2.degrees
      Object.defineProperty Number::, 'degrees',
        get: ->
          this * Math.TAU / 360

    unless 1.degree
      Object.defineProperty Number::, 'degree',
        get: ->
          this * Math.TAU / 360

>     #! example
>     180.degrees

---

Extra
-----

The mathematical circle constant of 1 turn.

    Math.TAU = 2 * Math.PI
