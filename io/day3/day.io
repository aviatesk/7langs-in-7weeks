## Interpret phone numbers in JSON format as Io hash
OperatorTable addAssignOperator(":", "atPutNumber") # "key: value" ==> `atPutNumber("key", value)`
curlyBrackets := method(
    r := Map clone
    call message arguments foreach(arg,
        r doMessage(arg) # ==> `r atPutNumber("key", value)`
    )
    r
)
Map atPutNumber := method(
    self atPut(
        call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
        call evalArgAt(1))
)

f := File with("./phonebook.json") openForReading contents
phoneNumbers := doString(f)
phoneNumbers keys   println
phoneNumbers values println


## hack on inheritance
# `forward` is a core of the inheritance system in Io, but we can hack even on it
# so in a sense, we can use `forward` as something like `method_missing` in Ruby
XMLBuilder := Object clone
XMLBuilder forward := method(
    tag := call message name
    writeln("<", tag, ">")
    call message arguments foreach(arg,
        content := self doMessage(arg)
        if(content type == "Sequence", writeln(content)) # `Sequence` is the type of a string
    )
    writeln("</", tag, ">")
)
XMLBuilder ul(
    li("Io")
    li("Lua")
    li("JavaScript")
)


## concurrency -- coroutines, actors, futures
# coroutines
# `yield` will voluntarily suspend the process and transfer to another process
vizzini := Object clone
fezzik  := Object clone
vizzini talk := method(
    "Fezzik, are there rocks ahead ?" println
    yield
    "No more rhymes now, I mean it." println
    yield
)
fezzik rhyme := method(
    yield
    "If there are, we'll all be dead." println
    yield
    "Anybody want a peanut ?" println
)

# `@@` will return `nil` and starts the message in its own thread
vizzini @@talk; fezzik @@rhyme
# Coroutine currentCoroutine pause

## actors
# actor: changes its own state and accesses other actors only through closely controlled queues
# thread in premiptive multitasking ?: subject to a concurrency problem called _race conditions_, where two threads access resources at the same time, leading to unpredictable results
slower := Object clone
faster := Object clone
slower start := method(wait(2); writeln("slowly"))
faster start := method(wait(1); writeln("quickly"))

# sequential run
slower start; faster start;

# concurrent run via asynchronous messages
slower @@start; faster @@start; wait(3) # ensure all the threads finish

## futures
obj := Object clone
# futureResult := URL with("http://google.com/") @fetch
obj fetch := method(
    wait(3)
    "now fetched"
)
future := obj @fetch
writeln("fetching should take 3 seconds.") # immedially executed
# will be blocked until the computation is complete
# NOTE: Future isn't a proxy implementation
writeln("result: ", future)
