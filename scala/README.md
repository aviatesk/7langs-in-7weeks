## runtime

spin up Scala Jupyter kernel ([almond](https://almond.sh/)):
- use 8888 port: `docker run --rm -p 8888:8888 -e JUPYTER_TOKEN=DockerJupyterAuthToken almondsh/almond:latest`
- use whatever port: `docker run --rm -p 8000:8000 -e JUPYTER_TOKEN=DockerJupyterAuthToken almondsh/almond:latest jupyter notebook --no-browser --ip=0.0.0.0 --port=8000`
- work in a container:
  * `docker run -it --rm -p 8888:8888 -v "$PWD":/root -e JUPYTER_TOKEN=DockerJupyterAuthToken almondsh/almond:latest bash`
  * `jupyter nbconvert <notebook> --to html`

run `scala` (or `sbt`):
- `docker run -it --rm -v "$PWD":/root hseeberger/scala-sbt:8u222_1.3.5_2.13.1`


## notes

differences from Java:
- **type inference**: Scala infers variable types where possible
- **functional concepts**: code blocks, higher-order functions, sophisticated collection library
- **immutable variables**: we need to explicitly make a decision about whether a variable is mutable
- **advanced programming constructs**: combining useful concepts, e.g. actors for concurrency, Ruby-style collections with higher-order functions, and first-class XML processing

functional programming characteristics:
- programs are made up of functions
- a function always returns a value
- a function, given the same inputs, will return the same value
- functional programs avoid changing state or mutating data; once we've set a value, we have to leave it alone

mutable vs. immutable for concurrency:
- def: "any variable that can hold more than one value, after initializations, is mutable"
- why mutable comes to be a problem for concurrent computations ?
  * "if two different threads can change the dame data at the same time, it's difficult to guarantee that the execution will leave the data in a valid state, and testing is nearly impossible"
- solutions:
  * (databases) transactions and locking
  * (OOP languages like C, Java) control access to shared data
  * (functional programming) eliminating mutable states !

_caveat_: Scala is not a pure functional programming language, while it offers tools that allow developers to use functional abstractions where they make sense.

TODO:
closure vs. code block:

other notable features
- trait-based mixin
- pattern matching
- method overloading (even on optional spaces, periods and semicolons): great tool for developing DSL
- XML-integration: important because the Java community is XML-heavy
