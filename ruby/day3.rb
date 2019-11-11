# %% open class
class NilClass
    def blank?
        true
    end
end
class String
    def blank?
        self.length == 0
    end
end
['', 'Ruby', nil].each do |e|
    puts e unless e.blank?
end

class Numeric
    def inches
        self
    end

    def feet
        self * 12.inches
    end

    def yards
        self * 3.feet
    end

    def miles
        self * 5280.feet
    end

    def back
        self * -1
    end

    def forward
        self
    end
end
puts 10.miles.back
puts 2.feet.forward

# %% method_missing
class Roman
    def self.method_missing name, *args
        roman = name.to_s
        roman.gsub!("IV", "IIII")
        roman.gsub!("IX", "VIIII")
        roman.gsub!("XL", "XXXX")
        roman.gsub!("XC", "LXXXX")

        (roman.count("I") +
         roman.count("V") * 5 +
         roman.count("X") * 10 +
         roman.count("L") * 50 +
         roman.count("C") * 100)
    end
end
puts Roman.X
puts Roman.XC
puts Roman.XII
puts Roman.LXXX

# %% metaprogramming -- macro, module

# # %% class based
# class ClassMD
#     def read
#         File.open(self.class.to_s + '.md') do |f|
#             f.each do |line|
#                 if (mat = /^#+?\s./.match line)
#                     @title = line[(mat.end(0) - 1)..].chomp
#                     break
#                 end
#             end
#
#             f.each do |line|
#                 @contents << line.chomp
#             end
#         end
#     end
#
#     attr_accessor :title, :contents
#
#     def initialize
#         @contents = []
#         read
#     end
# end
#
# class JuliaREADME < ClassMD
# end
# j = JuliaREADME.new
# puts j.title
# puts j.contents

# %% macro based
class MacroMD
    def self.acts_as_md
        define_method 'read' do
            File.open(self.class.to_s + '.md') do |f|
                f.each do |line|
                    if (mat = /^#+?\s./.match line)
                        @title = line[(mat.end(0) - 1)..].chomp
                        break
                    end
                end

                f.each do |line|
                    @contents << line.chomp
                end
            end
        end

        define_method 'title' do
            @title
        end

        define_method 'contents' do
            @contents
        end

        define_method 'initialize' do
            @contents = []
            read
        end
    end
end

class JuliaREADME < MacroMD
    acts_as_md
end
j = JuliaREADME.new
puts j.title
# puts j.contents

# %% module based
module ModuleMD
    def self.included(base)
        base.extend ClassMethods
    end

    module ClassMethods
        def acts_as_md
            include InstanceMethods
        end
    end

    module InstanceMethods
        attr_accessor :title, :contents

        def initialize
            read
        end

        def read
            @contents = []
            File.open(self.class.to_s + '.md') do |f|
                f.each do |line|
                    @contents << line.chomp

                    if (mat = /^#+?\s./.match line)
                        @title = line[(mat.end(0) - 1)..].chomp
                        break
                    end
                end

                f.each do |line|
                    @contents << line.chomp
                end
            end
        end
    end
end

class JuliaREADME
    include ModuleMD
    acts_as_md
end

j = JuliaREADME.new
puts j.title
puts j.contents

# %% self-study
module CSV
    def self.included base
        base.extend ClassMethods
    end

    module ClassMethods
        def acts_as_csv
            include InstanceMethods
        end
    end

    module InstanceMethods
        attr_accessor :headers, :contents

        def initialize
            read
        end

        def read
            @contents = []
            fileanme =
            File.open(self.class.to_s.downcase + '.csv', 'r') do |f|
                @headers = f.gets.chomp.split(', ')
                f.each do |row|
                    @contents << row.chomp.split(', ')
                end
            end
        end
    end
end
class Langs
    include CSV
    acts_as_csv
end
langs = Langs.new
puts langs.headers
puts langs.contents

module CSV
    module InstanceMethods
        def each &block
            @contents.each {|c| block.call(Row.new @headers, c)}
        end
    end
    class Row
        def initialize hs, c
            @headers = hs
            @content = c
        end
        def method_missing name, *args
            @content[@headers.index name.to_s]
        end
    end
end

langs.each {|r| puts r.name}
langs.each {|r| puts r.chapter}
langs.each {|r| puts r.pages}
