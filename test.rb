#!/opt/apps/ruby/ruby/bin/ruby

Signal.trap("INT"){puts "Interupt caught.";Kernel.exit(1)}
puts Signal.list
sleep 20
