# Scenario
#   You have two classes, a Car and Truck.  You want them to implement
#   similar functionality to drive (2 wheel for the car, 4 wheel for the truck)
#
# Implmentation
#  The adapter pattern using ruby classes.  You can also implement them with modules


# == Adapter Classes For Drive Nodes
class Drive
  class Adapters
    class Twowheel
      def self.drive()
        puts "Move car in two wheel drive"
      end
    end

    class Fourwheel
     def self.drive()
       puts "move car in four wheel drive"
     end
    end
  end
end

# == Vehicle Class - The Superclass
class Vehicle
  attr_reader :adapter

  def drive_adapter=(name)
    case name
    when Symbol, String
      @adapter = Drive::Adapters.const_get(name.to_s.capitalize)
    else
      raise "Missing adapter #{name}"
    end
  end

  # This is the common interface that we want behave differently based
  # on the object
  def drive()
    @adapter.drive
  end
end

# Truck Class
class Truck < Vehicle
end

# Car Class
class Car < Vehicle
end

# ================================================================
my_truck = Truck.new()
my_truck.drive_adapter = :fourWheel
my_truck.drive

my_car = Car.new()
my_truck.drive_adapter = :twoWheel
my_truck.drive