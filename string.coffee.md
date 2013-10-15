String
======

Extend strings with utility methods.

    {extend} = require "./util"

    extend String.prototype,

Returns true if this string only contains whitespace characters.

      blank: ->
        /^\s*$/.test(this)

>     #! example
>     "   ".blank()

---

Parse this string as though it is JSON and return the object it represents. If it
is not valid JSON returns the string itself.

      parse: () ->
        try
          JSON.parse(this.toString())
        catch e
          this.toString()

>     #! example
>     # this is valid json, so an object is returned
>     '{"a": 3}'.parse()

---

Returns true if this string starts with the given string.

      startsWith: (str) ->
        @lastIndexOf(str, 0) is 0

Returns true if this string ends with the given string.

      endsWith: (str) ->
        @indexOf(str, @length - str.length) != -1

Get the file extension of a string.

      extension: ->
        if extension = this.match(/\.([^\.]*)$/, '')?.last()
          extension
        else
          ''

>     #! example
>     "README.md".extension()

---

Assumes the string is something like a file name and returns the
contents of the string without the extension.

      withoutExtension: ->
        this.replace(/\.[^\.]*$/, '')

      toInt: (base=10) ->
        parseInt(this, base)

>     #! example
>     "neat.png".witouthExtension()

---