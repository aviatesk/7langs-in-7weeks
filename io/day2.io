## control flow
# loop("getting dizzy ..." println)
i := 1
while(i <= 5, i println; i = i + 1); "This one goes up to 5" println
for(i, 1, 5, i println); "This one goes up to 5" println
for(i, 1, 5, 2, i println); "This one goes up to 5" println

# extra arguments
for(i, 1, 2, 1, i println, "extra argument")
for(i, 1, 2, i println, "extra argument") # `i println` comes to be the optional increment argument, and `"extra argument"` comes to be a message

if(true, "It is true.", "It is false.") println
if(false) then("It is true") else("It is false")
if(false) then("It is true" println) else("It is false" println)

## operators
# operator table
# Io> OperatorTable println
# Operators
#   0   ? @ @@
#   1   **
#   2   % * /
#   3   + -
#   4   << >>
#   5   < <= > >=
#   6   != ==
#   7   &
#   8   ^
#   9   |
#   10  && and
#   11  or ||
#   12  ..
#   13  %= &= *= += -= /= <<= >>= ^= |=
#   14  return
#
# Assign Operators
#   ::= newSlot
#   :=  setSlot
#   =   updateSlot
#
# To add a new operator: OperatorTable addOperator("+", 4) and implement the + message.
# To add a new assign operator: OperatorTable addAssignOperator("=", "updateSlot") and implement the updateSlot message.
# more smaller a number is, the higher precedence an operator has

# add our own operator
OperatorTable addOperator("xor", 11)
true  xor := method(bool, if(bool, false, true))
false xor := method(bool, if(bool, true, false))
true  xor true  # ==> false
true  xor false # ==> true
false xor true  # ==> true
false xor false # ==> false

## message reflection
# receiver
postOffice := Object clone
postOffice packageSender := method(call sender) # should show a sender (`mailer`)
postOffice messageTarget := method(call target) # should show a receiver itself (`postOffice`)
# sender
mailer := Object clone
mailer deliver := method(postOffice packageSender) # send a message to a receiver (`postOffice`)
# reflection on a message itself
postOffice messageArgs   := method(call message arguments)
postOffice messageName   := method(call message name)
postOffice messageArgs("one", 2, :three) # ==> list("one", 2, : three)
postOffice messageName                   # ==> messageName

## when Io evaluates a message ? ==> Pass a message itself and its context, and a "receiver" will evaluate it.
# `doMessage` is like a `eval` in Ruby
unless := method(
    (call sender doMessage(call message argAt(0))) ifFalse(
	call sender doMessage(call message argAt(1))) ifTrue(
	call sender doMessage(call message argAt(2)))
)

# how `unless` works
westley := Object clone
westley trueLove := true
westley princessButtercup := method(unless(trueLove, "It is false" println, "It is true" println))
westley princessButtercup
# 1. `westley` sends the `princessButtercup` message.
# 2. Io takes the interpreted message and the context (the call sender, target, and message) and puts it on the stack
# 3. Now `princessButtercup` slot evaluates the message. There is no `unless` slot, so Io walks up the prototype chain until it finds `unless`.
# 4. Io begins executing the `unless` message. First, Io executes `call sender doMessage(call message argAt(0))`. That code simplifies to `westley trueLovel`
# 5. The message is not `false`, so Io will execute the third code block, which simplifies to `westley ("It is true" println)`

## object reflection
Object ancestors := method(
    prototype := self proto
    if(prototype != Object,
        writeln("Slots of ", prototype type, "\n----------------")
        prototype slotNames foreach(slotName, writeln(slotName))
        writeln
        prototype ancestors
    )
)
Animal := Object clone
Animal speak := method("ambiguos animal noise" println)
Duck := Animal clone
Duck speak := method("quark" println)
Duck walk := method("waddle" println)
disco := Duck clone
disco ancestors

## self study

# 1. Fibonacci sequence
fib := method(n,
	if(n == 0) then(
		return n
	) elseif(n == 1) then(
		return n
	) else(
		return fib(n - 1) + fib(n - 2)
	)
)
fib(1) println  # ==> 1
fib(4) println  # ==> 3
fib(10) println # ==> 55

# 2. change `/` to return `0` if the denominator is zero.
originalDiv := Number getSlot("/")
Number / := method(n, if(n == 0, 0, self originalDiv(n)))
(3 / 0) println # ==> 0
(3 / 2) println # ==> 1.5

# 3. sum up a two-dimensional array
sum2DArray := method(ary,
	s := 0
	ary foreach(a, s = s + a sum)
	return s
)
sum2DArray(list(list(1), list(2, 3), list(4))) println # ==> 10

# 4. `myAverage`
Object isNumber := method(self type == Number type)
List myAverage := method(
	lst := self select(isNumber)
	if (lst isEmpty) then(
		Exception raise("There is no numeric element")
	) else(
		return lst average
	)
)
list(1, 2, 3, 4, 5) myAverage println     # ==> 3
list(1, 2, 3, "4", "5") myAverage println # ==> 2
err := try(
	list("1") myAverage # ==> should raise an error
)
if (err type == Exception type, writeln("The error happened as expected."))

# TODO: 5 to 8.
