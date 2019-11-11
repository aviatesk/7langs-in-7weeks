# %% markdown
# _Every_ thing is an object in Ruby world
#
# オブジェクト指向:
# - カプセル化(データと振る舞いを1つにまとめること)
# - クラスによる継承(クラスツリーによって編成されたオブジェクト型)
# - ポリモーフィズム(多くの形態をとることができるオブジェクト)

# %%
'hello, world'

language = 'Ruby'
"hello, #{language}"

language = 'my Ruby'
"hello, #{language}"

4.class
4.methods

x = 4
x < 5
x <= 4
x > 4
false.class
true.class

# %%
x = 4
puts 'This appears to be false.' unless x == 4
puts 'This appears to be true.' if x == 4
puts 'This appears to be true.' if not true
puts 'This appears to be true.' if !true
if x == 4
    puts 'This appers to be true.'
end
unless x ==4
    puts 'This appers to be false.'
else
    puts 'This appers to be true.'
end

# %%
x = x + 1 while x < 10
x
x = x - 1 until x == 1
x
while x < 10
    x = x + 1
    puts x
end

# %%
puts 'This appears to be true.' if 1
puts 'This appears to be true.' if 'random string'
puts 'This appears to be true.' if 0
puts 'This appears to be true.' if nil

# %%
true and false
true or false
false && false
true && this_will_cause_an_error
false && this_will_not_cause_an_error
true || this_will_not_cause_an_error

true | 'not returned'
true | this_will_cause_an_error

# %% markdown
# dynamic typing:
# Rubyは型チェックをコンパイル時ではなく実行時に行う => 動的型付け

# %%
4 + 'four'
4.class
(4.0).class
4 + 4.0

# %%
def add_them_up
    4 + 'four' # 実行時にエラー
end
add_them_up

# %% markdown
# duck typing:
# > アヒルのように歩き, アヒルのようにガーガー鳴く動物がいたら, それはアヒル
#
# 純粋なオブジェクト指向設計を行う場合に極めて重要な概念となる:
# - オブジェクト指向の設計哲学: "実装ではなく, インターフェースに合わせてコーディングする"
# - duck typing はほとんど何の作法もなしに, これを適用できる

# %%
i = 0
a = ['100', 100.0]
while i < 2
    puts a[i].to_i
    i = i + 1
end

# %% self study
puts "Hello, world"

puts "Hello, Ruby".index 'Ruby'

for i in 1..10
    puts "I'm Shuhei Kadowaki."
end

for i in 1..10
    puts "This is sentence number #{i}"
end

# n = IRuby.input().to_i # doesn't work in Hydrogen
n = 5
puts n > rand(10)
