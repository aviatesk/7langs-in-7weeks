// %% markdown
// ### day 1
//

// %% markdown
// in Scala, everything is an object, except some small exceptions

// %%
5 + 4 * 3
(5).+(4.*(3))
"abc".size

// %% markdown
// type coercing (via type inference)

// %%
"abc" + 4
4 + "1.0"

// %% markdown
// compile time type error; Scala REPL actually compiles lines of code and runs each one piecemean

// %%
4 * "1.0"

// %% markdown
// declaration:
// - no need to explicitly type annotate (thanks to type inference)
// - `val` vs. `var`:
//   * `val`: immutable
//   * `var`: mutable

// %%
val vl = 1
// val vl: Int = 1 // equivalent to above
// vl = 2 // errors

var vr = 1
vr = 2

// %% markdown
// conditions ?:
// - only `Boolean` type is accepted as conditions
// - we can't use e.g. `0` or `Nil` (an empty list) as conditions

// %%
if (true) { println("true") }

// %%
if (0) { println("false ?") }

// %% markdown
// Loops

// %%
// no need to annotate `public` ! (it's default in Scala)
def whileLoop() {
  var i = 1
  while (i <= 3) {
    println(i)
    i += 1
  }
}
whileLoop()

// %%
def forLoop(args: Range) {
  println("for loop using Java-style iteration")
  for (i <- 0 until args.length) {
    println(args(i))
  }
}
forLoop(1 until 3)

def forEach(args: Range) {
  println("for loop using Ruby-style iteration")
  args.foreach { arg =>
    println(arg)
  }
}
forEach(1 until 3)

// %% markdown
// `Range`s

// %%
// `until` vs. `to`
0 until 10 // non-inclusive
(0 to 10) // inclusive

// steps
(0 to 10) by 5
(10 until 0) by -1
(10 until 0)  // the default step is "always" `1`

// other
'a' to 'e'

// %% markdown
// Tuples

// %%
val me = ("Shuhei", "Kadowaki")
me._1
me._2

// %%
me._3 // compile time error; meaning Tuple has a fixed length

// %%
val (te1, te2) = (1, 2)

// %% markdown
// Classes
//
// simple class:
// ```scala
// class Person(firstName: String, lastName: String)
// ```

// %%
class Person(firstName: String, lastName: String)
val me = new Person("Shuhei", "Kadowaki")

// %%
// do more complex
class Compass {
  // NOTE: the code block below are all _constructors_

  val directions = List("north", "east", "south")
  var bearing = 0
  print("Initial bearing: ")
  println(direction)

  def direction() = directions(bearing)

  def inform(turnDirection: String) {
    println("Turning " + turnDirection + ". Now bearing " + direction)
  }

  def turnRight() {
    bearing = (bearing + 1) % directions.size
    inform("right")
  }

  def turnLeft() {
    bearing = (bearing + (directions.size - 1)) % directions.size
    inform("left")
  }
}

val compass = new Compass
compass.turnRight
compass.turnRight()
compass.turnLeft
compass.turnLeft
compass.turnLeft

// %%
// **auxiliary constructors**
class Person(firstName: String) {
  println("Outer constructor")

  // NOTE: this is an auxiliary constructor
  def this(firstName: String, lastName: String) {
    this(firstName)
    println("Inner constructor")
  }

  def talk() = println("Hi")
}

val s = new Person("Shuhei")
val sk = new Person("Shuhei", "Kadowaki")

// %% markdown
// Objects vs. Classes (_**companion objects**_)
// - `object` definition for singleton object
// - `class` definition for class instances
//
// NOTE: In Scala, we can have both an `object` definition and a `class`  definition with the same name.

// %%
object TrueRing {
  def rule = println("To rule them all")
}
TrueRing.rule

// %% markdown
// Inheritance

// %%
// NOTE:
// `override` seems verbose, but also useful for avoding misspellings,
// but, ..., this really looks like the old f*cking Java ...
class Person(val name: String) {
  def talk(message: String) = println(name + " says " + message)
}

class Employee(override val name: String,
                        val number: Int) extends Person(name) {
  override def talk(message: String) {
    println(name + " with number " + number + " says " + message)
  }

  def id(): String = number.toString
}

val employee = new Employee("Yoda", 4)
employee.talk("Extend or extend not. There is no try.")

// %% markdown
// **Traits**
//
// > a trait is like a Java interface plus an implementation.

// %%
class Person(val name: String)

// like a Ruby's mixin
trait Nice {
  def greet() = println("Howdily doodily.")
}

class Character(override val name: String) extends Person(name) with Nice

val flanders = new Character("Ned")
flanders.greet // any instance of `Character` has `greet` method now
