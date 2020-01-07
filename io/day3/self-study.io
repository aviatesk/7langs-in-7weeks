## enhance the XML program to add spaces to show the indentation structure

XMLBuilder := Object clone
XMLBuilder level := 0
XMLBuilder indents := method("  " repeated(level))
XMLBuilder forward := method(
    tag := call message name

    writeln(self indents, "<", tag, ">")
    level = level + 1

    call message arguments foreach(arg,
        content := doMessage(arg)
        if(content type == "Sequence", writeln(indents, content)) # `Sequence` is the type of a string
    )

    level = level - 1
    writeln(indents, "</", tag, ">")
)

XMLBuilder details(
    summary("Prototype-based languages")
    ul(
        li("Io")
        li("Lua")
        li("JavaScript")
    )
)

## create a list syntax that uses brackets

squareBrackets := method(
    call message arguments
)
List squareBrackets := method(index, value,
    if(value == nil, at(index), atPut(index, value))
)
ls := ["Io", "Lua", "JavaScript"]
ls println
ls[1] println
ls push("TypeScript") println
ls[3, "TypeScript ?"] println


## enhance the XML program to handle attributes:
##   if the first argument is a map (use the curly brackets syntax),
##   add attributes to the XML program
