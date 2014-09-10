#!/opt/apps/ruby/ruby/bin/ruby
#
class Person
  attr_accessor :fname
  def initialize()
    @fname = "Sean"
  end

end

class Family
  attr_accessor :person1
  def initialize(person)
    @person1 = person
    @person1.fname = "Lisa"
  end
end

person1 = Person.new()
puts person1.fname

family = Family.new(person1)
puts family.person1
puts person1.fname
