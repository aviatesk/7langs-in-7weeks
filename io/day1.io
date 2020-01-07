# Hello world
"Hello, Io" println

## slot -- object is a collection of slots
Vehicle := Object clone
Vehicle description := "Something to take you places"
Vehicle description
Vehicle description = "Something to take you far away"
# Vehicle noexistingSlot = "This won't work" # would cause error
Vehicle slotNames

## type
Vehicle type
Object type

## prototype, inheritance
Car := Vehicle clone
Car slotNames
Car type
Car description # look for `Vehicle`'s slot

ferrari := Car clone
ferrari type # return the prototype's type since this object's name starts with an lowercase
Ferrari := Car clone
Ferrari type # return its own type since this object's name starts with an uppercase

# the only difference between object and type is whether they have `type` slot or not
ferrari slotNames
Ferrari slotNames

## method
method("So, you've come for an argument." println)
method() type # method is an object as well
Car drive := method("Vroom" println)
ferrari drive # call method
ferrari getSlot("drive")
# get prototype
ferrari proto
Car proto

# `Lobby` holds every named object
Lobby println

## # The prototype programming paradigm:
# - Every _thing_ is an object.
# - Every _interaction_ with an object is a message.
# - You don't instantiate classes -- you clone other objects called _prototypes_.
# - Objects remember their prototypes.
# - Objects have slots.
# - Slots contain objects, including method objects.
# - A message returns the value in a slot or invokes the method in a slow.
# - If an object can't respond to a message, it sends that message to its prototype.

## collections
# list
toDos := list("finish Io days", "finish writing impressions")
toDos size
toDos append("finish Prolog days")

list(1, 2, 3, 4) average
list(1, 2, 3, 4) sum
list(1, 2, 3) at(1)
list(1, 2, 3) append(4)
list(1, 2, 3) pop
list(1, 2, 3) prepend(0)
list() isEmpty

# map
7langs := Map clone # no syntax sugar
7langs atPut("Ruby", "chapter2")
7langs at("Ruby")
7langs atPut("Io", "chapter3")
7langs asObject
7langs asList
7langs keys
7langs size

## control flow
4 < 5 and 6 > 7
0 and true # `0` is true value

# singleton
# `true`, `false` and `nil` are singletons
"true proto type" println
true proto type println
"true clone" println
true clone println
"false clone" println
false clone println
"nil clone" println
nil clone println

# make singletons
Singleton := Object clone
Singleton clone := Singleton # redefine `clone` method
# clone of `Singleton` comes to be itself
s1 := Singleton clone
s2 := Singleton clone
s1 == s2
# this is not always true, of course
o1 := Object clone
o2 := Object clone
o1 == o2

# okay, we have such a fundamental freedom, but this comes with a corresponding responsibility
# Object clone := "shouldn't do this !"

## self study
if (0, "0 is true", "0 is false") println
if ("", "\"\" is true", "\"\" is false") println
if (nil, "nil is true", "nil is false") println

# ::=	Creates slot, creates setter, assigns value
# :=	Creates slot, assigns value
# =	Assigns value to slot if it exists, otherwise raises exception
