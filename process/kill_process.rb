#!/opt/apps/ruby/ruby/bin/ruby

begin
  Process.kill("TERM",1111)
  puts "Process Killed"
rescue Errno::ESRCH
  puts "The process did not exist"
end
