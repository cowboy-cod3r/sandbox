#!/usr/bin/ruby

# Metaclass is a class that defines a class.


class Sean
  class << self
    def dog
      puts "woof woof"
    end
  end
end

Sean.dog
