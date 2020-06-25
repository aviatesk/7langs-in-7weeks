// %% markdown
// ### day 2
//

// %% markdown
// #### Collections (`List`s, `Set`s, and `Map`s)

// %% markdown
// `List`s

// %%
Nil
List(1, 2, 3)
List("one", "two", "three")
List("one", "two", 3)
List("one", "two", 3)(2) // `Any` gets returned

// %%
List("one", "two", 3)(3)

// %%
List("one", "two", 3)(-1)

// %% markdown
// `Set`s

// %%
val animals = Set("lions", "tigers", "bears")

// NOTE:
// these operations are NOT destructive;
// each set operation builds a new set rather than modifying the old ones
animals + "armadillos"
animals - "tigers"
animals ++ Set("armadillos", "raccoons")
animals -- Set("lions", "bears")
animals & Set("almadillos", "raccoons", "lions", "tigers")

Set(1, 2, 3) == Set(3, 2, 1)

// %% markdown
// `Map`s

// %%
val ordinals = Map(0 -> "zero", 1 -> "one", 2 -> "two")
ordinals(2)

// %%
import scala.collection.mutable.HashMap

val map = new HashMap[Int, String] // "immutable" here means the _reference_ to this `map` cannot change
map += 4 -> "four"
map += 8 -> "eight"
map // mutated !

// %%
map += "zero" -> 0 // error if given wrong type, of course

// %% markdown
// Scala type hierarchy:
// - `Any`: the root class in the Scala class hierarchy; any Scala type will inherit from `Any`
// - `Nothing`: a subtype of every type
// ![scala-type-hierarchy](./scala-type-hierarchy.png)

// %% markdown
// Scala nil concepts:
// - `Null` is a trait, and `null` is an instance of `Null` (meaning "an empty value")
// - `Nothing` is a trait but has no instance; e.g. a method that throws an `Exception` has the return type `Nothing`
// - `Nil` is an empty collection

// %% markdown
// #### Higher order functions (a.k.a. _code blocks_ in Scala)

// %%
// data
val list = List("frodo", "samwise", "pippin")
list.foreach(hobbit => println(hobbit))

val set = Set("frodo", "samwise", "pippin")
set.foreach(hobbit => println(hobbit))

val map = Map("frodo" -> "hobbit", "samwise" -> "hobbit", "pippin" -> "hobbit")
map.foreach(hobbit => println(hobbit._1))

// %%
// prepare for interation / recursion on `List`s
val list = List("frodo", "samwise", "pippin")
list.isEmpty
Nil.isEmpty
list.length
list.size
list.head
list.tail
list.init
list.last

// utilties; don't mutate the list
list.reverse
list.drop(1)
list.drop(2)

// %%
// HoF !
val words = List("peg", "al", "bud", "kelly")
words.count(word => word.size > 2)
words.filter(word => word.size > 2)
words.map(word => word.size)
words.forall(word => word.size > 1)
words.exists(word => word.size > 4)
words.exists(word => word.size > 5)

words.sortWith((s, t) => s.charAt(0).toLower < t.charAt(0).toLower)
words.sortWith((s, t) => s.size < t.size)

// %%
// fold
val list = List(1, 2, 3)

// two versions
// 1. this one looks really odd ..
(0 /: list)((sum, i) => sum + i)
// 2. carrying
list.foldLeft(0)((s, i) => s + i)
