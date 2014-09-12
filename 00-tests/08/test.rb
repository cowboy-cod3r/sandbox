#!/opt/apps/ruby/ruby/bin/ruby
# Sides of the dice
range = 1..6

# Simple Threading Application
number_of_threads = 1..2
threads = []

number_of_threads.each do |i|
  threads << Thread.new(i) do |thread|
  # Unique ID for the current thread
    puts "Dice #{i}: " + rand(range).to_s + "\n"
  end
end

# Wait for threads to complete before moving on
threads.each do |thread|
  thread.join()
end
