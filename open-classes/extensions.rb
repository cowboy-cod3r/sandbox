class Numeric
  def to_money
    puts self.class
    #Money.new(self * 100)
  end
end

x = 1

puts 1.to_money
