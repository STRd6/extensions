Array
=====

    {extend} = require "./util"

    extend Array.prototype,

Calculate the average value of an array. Returns undefined if some elements
are not numbers.

      average: ->
        @sum()/@length

>     #! example
>     [1, 3, 5, 7].average()

----

Returns a copy of the array without null and undefined values.

      compact: ->
        @select (element) ->
          element?

>     #! example
>     [null, undefined, 3, 3, undefined, 5].compact()

----

Creates and returns a copy of the array. The copy contains
the same objects.

      copy: ->
        @concat()

>     #! example
>     a = ["a", "b", "c"]
>     b = a.copy()
>
>     # their elements are equal
>     a[0] == b[0] && a[1] == b[1] && a[2] == b[2]
>     # => true
>
>     # but they aren't the same object in memory
>     a is b
>     # => false

----

Empties the array of its contents. It is modified in place.

      clear: ->
        @length = 0
    
        return this

>     #! example
>     fullArray = [1, 2, 3]
>     fullArray.clear()
>     fullArray

----

Flatten out an array of arrays into a single array of elements.

      flatten: ->
        @inject [], (a, b) ->
          a.concat b

>     #! example
>     [[1, 2], [3, 4], 5].flatten()
>     # => [1, 2, 3, 4, 5]
>
>     # won't flatten twice nested arrays. call
>     # flatten twice if that is what you want
>     [[1, 2], [3, [4, 5]], 6].flatten()
>     # => [1, 2, 3, [4, 5], 6]

----

Invoke the named method on each element in the array
and return a new array containing the results of the invocation.

      invoke: (method, args...) ->
        @map (element) ->
          element[method].apply(element, args)

>     #! example
>     [1.1, 2.2, 3.3, 4.4].invoke("floor")

----

>     #! example
>     ['hello', 'world', 'cool!'].invoke('substring', 0, 3)

----

Randomly select an element from the array.

      rand: ->
        @[rand(@length)]

>     #! example
>     [1, 2, 3].rand()

----

Remove the first occurrence of the given object from the array if it is
present. The array is modified in place.

      remove: (object) ->
        index = @indexOf(object)
    
        if index >= 0
          @splice(index, 1)[0]
        else
          undefined

>     #! example
>     a = [1, 1, "a", "b"]
>     a.remove(1)
>     a

----

Returns true if the element is present in the array.

      include: (element) ->
        @indexOf(element) != -1

>     #! example
>     ["a", "b", "c"].include("c")

----

Call the given iterator once for each element in the array,
passing in the element as the first argument, the index of
the element as the second argument, and this array as the
third argument.

      each: (iterator, context) ->
        if @forEach
          @forEach iterator, context
        else
          for element, i in this
            iterator.call context, element, i, this
    
        return this

>     #! example
>     word = ""
>     indices = []
>     ["r", "a", "d"].each (letter, index) ->
>       word += letter
>       indices.push(index)
>
>     # => ["r", "a", "d"]
>
>     word
>     # => "rad"
>
>     indices

----

Call the given iterator once for each pair of objects in the array.

      eachPair: (iterator, context) ->
        length = @length
        i = 0
        while i < length
          a = @[i]
          j = i + 1
          i += 1
    
          while j < length
            b = @[j]
            j += 1
    
            iterator.call context, a, b

>     #! example
>     results = []
>     [1, 2, 3, 4].eachPair (a, b) ->
>       results.push [a, b]
>     
>     results

----

Call the given iterator once for each element in the array,
passing in the element as the first argument and the given object
as the second argument. Additional arguments are passed similar to
`each`.

      eachWithObject: (object, iterator, context) ->
        @each (element, i, self) ->
          iterator.call context, element, object, i, self
    
        return object

Call the given iterator once for each group of elements in the array,
passing in the elements in groups of n. Additional arguments are
passed as in `each`.

      eachSlice: (n, iterator, context) ->
        len = @length / n
        i = -1
  
        while ++i < len
          iterator.call(context, @slice(i*n, (i+1)*n), i*n, this)
    
        return this

>     #! example
>     results = []
>     [1, 2, 3, 4].eachSlice 2, (slice) ->
>       results.push(slice)
> 
>     results

----

Pipe the input through each function in the array in turn. For example, if you have a
list of objects you can perform a series of selection, sorting, and other processing
methods and then receive the processed list. This array must contain functions that
accept a single input and return the processed input. The output of the first function
is fed to the input of the second and so on until the final processed output is returned.

      pipeline: (input) ->
        @inject input, (input, fn) ->
          fn(input)

Returns a new array with the elements all shuffled up.

      shuffle: ->
        shuffledArray = []
    
        @each (element) ->
          shuffledArray.splice(rand(shuffledArray.length + 1), 0, element)
    
        return shuffledArray

>     #! example
>     [0..9].shuffle()

----

Returns the first element of the array, undefined if the array is empty.

      first: ->
        @[0]

>     #! example
>     ["first", "second", "third"].first()

----

Returns the last element of the array, undefined if the array is empty.

      last: ->
        @[@length - 1]

>     #! example
>     ["first", "second", "third"].last()

----

Returns an object containing the extremes of this array.

      extremes: (fn=identity) ->
        min = max = undefined
        minResult = maxResult = undefined
    
        @each (object) ->
          result = fn(object)
    
          if min?
            if result < minResult
              min = object
              minResult = result
          else
            min = object
            minResult = result
    
          if max?
            if result > maxResult
              max = object
              maxResult = result
          else
            max = object
            maxResult = result
    
        min: min
        max: max

>     #! example
>     [-1, 3, 0].extremes()

----

      maxima: (valueFunction=identity) ->
        @inject([-Infinity, []], (memo, item) ->
          value = valueFunction(item)
          [maxValue, maxItems] = memo
    
          if value > maxValue
            [value, [item]]
          else if value is maxValue
            [value, maxItems.concat(item)]
          else
            memo
        ).last()
    
      maximum: (valueFunction) ->
        @maxima(valueFunction).first()
    
      minima: (valueFunction=identity) ->
        inverseFn = (x) ->
          -valueFunction(x)
    
        @maxima(inverseFn)
    
      minimum: (valueFunction) ->
        @minima(valueFunction).first()

Pretend the array is a circle and grab a new array containing length elements.
If length is not given return the element at start, again assuming the array
is a circle.

      wrap: (start, length) ->
        if length?
          end = start + length
          i = start
          result = []
    
          while i < end
            result.push(@[mod(i, @length)])
            i += 1
    
          return result
        else
          return @[mod(start, @length)]

>     #! example
>     [1, 2, 3].wrap(-1)

----

>     #! example
>     [1, 2, 3].wrap(6)

----

>     #! example
>     ["l", "o", "o", "p"].wrap(0, 12)

----

Partitions the elements into two groups: those for which the iterator returns
true, and those for which it returns false.

      partition: (iterator, context) ->
        trueCollection = []
        falseCollection = []
    
        @each (element) ->
          if iterator.call(context, element)
            trueCollection.push element
          else
            falseCollection.push element
    
        return [trueCollection, falseCollection]

>     #! example
>     [0..9].partition (n) ->
>       n % 2 is 0    

----

Return the group of elements for which the return value of the iterator is true.

      select: (iterator, context) ->
        return @partition(iterator, context)[0]
  
Return the group of elements that are not in the passed in set.

      without: (values) ->
        @reject (element) ->
          values.include(element)

>     #! example
>     [1, 2, 3, 4].without [2, 3]

----

Return the group of elements for which the return value of the iterator is false.

      reject: (iterator, context) ->
        @partition(iterator, context)[1]

Combines all elements of the array by applying a binary operation.
for each element in the arra the iterator is passed an accumulator
value (memo) and the element.

      inject: (initial, iterator) ->
        @each (element) ->
          initial = iterator(initial, element)

        return initial

Add all the elements in the array.

      sum: ->
        @inject 0, (sum, n) ->
          sum + n
          
>     #! example
>     [1, 2, 3, 4].sum()

----

Multiply all the elements in the array.

      product: ->
        @inject 1, (product, n) ->
          product * n

>     #! example
>     [1, 2, 3, 4].product()

----

Produce a duplicate-free version of the array.

      unique: ->
        @inject [], (results, element) ->
          results.push element if results.indexOf(element) is -1
    
          results

Merges together the values of each of the arrays with the values at the corresponding position.

      zip: (args...) ->
        @map (element, index) ->
          output = args.map (arr) ->
            arr[index]

          output.unshift(element)

          return output

>     #! example
>     ['a', 'b', 'c'].zip([1, 2, 3])

----

Helpers
-------

    identity = (x) ->
      x

    rand = (n) ->
      Math.floor n * Math.random()

    mod = (n, base) ->
      result = n % base
  
      if result < 0 and base > 0
        result += base

      return result
