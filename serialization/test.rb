#!/opt/apps/ruby/ruby/bin/ruby

require 'yaml'
require 'json'

class MyPerson
  attr_accessor :f_name, :l_name
  def initialize(f_name, l_name)
    @f_name = f_name
    @l_name = l_name
  end

  def to_json(*a)
    {
      "json_class" => self.class.name,
      "data"       => {"f_name" => @f_name, "l_name" => @l_name }
    }.to_json(*a)
  end

  def full_name
    @f_name + " " + @l_name
  end

end

# Create an instance of the object
person = MyPerson.new("Sean", "Humbarger")

# Serialize it via yaml
puts "Serializing via yaml"
puts "==================================="
serialized_yaml = YAML::dump(person)
puts serialized_yaml
puts serialized_yaml.class
unserialized = YAML::load(serialized_yaml)
puts unserialized.inspect

puts "==================================="
puts

puts "Serializing via marshal (binary)"
puts "==================================="
serialized_marshal = Marshal::dump(person)
puts serialized_marshal.class
unserialized_marshal = Marshal.load(serialized_marshal)
puts unserialized_marshal
puts "==================================="

puts "Serializing via json"
puts "==================================="
json_str = person.to_json
serialized_json = JSON.parse(json_str)
puts serialized_json
puts "==================================="

