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
// `Range`s and Tuples

// %%
