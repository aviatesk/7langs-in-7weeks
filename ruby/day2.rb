# encoding: utf-8

# %% array
animals = ['lions', 'tigers', 'bears']
puts animals[0]
puts animals[3]
puts animals[-1]
puts animals[-4]
animals[0..1]
(0..1).class

a = []
a.class
a.methods.include?(:[])
a[0] = 'zero'
a[1] = 1
a[2] = ['two', 2]
a

# %% hash
numbers = {1 => 'one', 2 => 'two'}
numbers[1]
numbers[2]
stuff = {:array => [1, 2, 3], :string => 'Hi, Ruby !'}
stuff[:string]

# %% symbol -- phisically unique
puts 'string'.object_id
puts 'string'.object_id

puts :string.object_id
puts :string.object_id

# %% keyword arguments using hash
def tell_the_truth(options = {})
    if options[:profession] == :lawyer
        'it could be believed that this is almost certainly not false'
    else
        true
    end
end
tell_the_truth # an empty hash `{}` would be passed as `options`
tell_the_truth :profession => :lawyer

# %% code block
# code block is annonymous function
3.times {puts 'hi there, code block'}
3.times do
    puts 'hi there, code block'
end

animals.each {|a| puts a}

# code can be passed to functions and methods as their arguments
def call_block(&block)
    block.call
end
def pass_block(&block)
    call_block(&block)
end
pass_block {puts "I\'m passed as an argument !"}

# %% external method definition
class Integer
    def my_times
        i = self
        while i > 0
            i = i - 1
            yield
        end
    end
end

3.my_times {puts 'external dispatch ?'}

# %% class hierarchy
# 4
# |
# Integer -> Numeric -> Object -> BasicObject
# |
# Class   -> Module  -> Object -> BasicObject
4.class
4.class.superclass
4.class.superclass.superclass
4.class.superclass.superclass.superclass
4.class.superclass.superclass.superclass.superclass

4.class.class
4.class.class.superclass
4.class.class.superclass.superclass

# %%
class Tree
    attr_accessor :children, :node_name

    def initialize(name, children = []) # called when instantiation
        @children  = children
        @node_name = name
    end

    def visit_all(&block)
        visit &block
        children.each {|c| c.visit_all &block}
    end

    def visit(&block)
        block.call self
    end
end

ruby_tree = Tree.new('Ruby', [
    Tree.new('Reia'),
    Tree.new('MacRuby')
])
puts "--- Visiting a node ---"
ruby_tree.visit {|node| puts node.node_name}

puts "--- Visiting entire tree ---"
ruby_tree.visit_all {|node| puts node.node_name}

puts "--- Renamed ? ---"
ruby_tree.node_name='Ruby?'
ruby_tree.visit_all {|node| puts node.node_name}

# %% markdown
# `module` による "Mixin" (機能の混ぜ込み)
# - 単純な単一継承によりクラスの中核部分を定義
# - `module` で機能を追加する

# %%
module ToFile
    def filename
        "_object_#{self.object_id}.txt"
    end

    def to_f
        File.open(filename, 'w') {|f| f.write(to_s)} # to_s はダックタイピングによって暗黙的に呼ばれることになる, c.f.: Java
    end
end

class Person
    include ToFile # mixin ! (ファイルに書き出す機能を「混ぜ込む(mixin)」)
    attr_accessor :name

    def initialize(name)
        @name = name
    end

    def to_s
        name
    end
end

Person.new('matz').to_f

# %% markdown
# Mixin examples
# - `Enumerable`
# - `Comparable`: `<=>`

# %%
'begin' <=> 'end'
'same' <=> 'same'
ary = [5, 3, 4, 1]
Integer.method_defined?(:<=>)
ary.sort
ary.any? {|a| a > 6}
ary.any? {|a| a > 4}
ary.all? {|a| a > 4}
ary.all? {|a| a > 0}
ary.collect {|i| 2 * i}
ary.select {|i| i % 2 == 0}
ary.select {|i| i % 2 == 1}
ary.max
ary.member? 2
ary.inject(0) {|sum, i| sum + i}
ary.inject {|sum, i| sum + i}
ary.inject {|product, i| product * i}

ary.inject(0) do |sum, i|
    puts "sum: #{sum}   i: #{i}   sum + i: #{sum + i}"
    sum + i
end

## self-study:

# %% markdown
# ファイルアクセスにおいて, コードブロックを使う利点は ?:
# ```julia
# function open(f::Function, args...)
#     io = open(args...)
#     try
#         f(io)
#     finally
#         close(io)
#     end
# end
# ...
# open("outline", "w") do io
#     write(io, data)
# end
# ```
#
# > Here, `open` first opens the file for writing and then passes the resulting output stream to
# > the anonymous function you defined in the `do ... end` block. After your function exits, `open`
# > will make sure that the stream is properly closed, regardless of whether your function exited
# > normally or thre an exception.

# %%
# Rubyの文字コード周り面倒 ...
regex = /\.*julia\.*/i
File.open('JuliaREADME.md', 'r') do |f|
    f.readlines.each_with_index do |line, index|
        if line.match(regex)
            puts "#{index}: #{line}"
        end
    end
    nil
end
