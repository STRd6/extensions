Util
====

Utility methods shared in our extensions.

    module.exports =

Extend an object with the properties of other objects.

      extend: (target, sources...) ->
        for source in sources
          for name of source
            target[name] = source[name]
      
        return target
