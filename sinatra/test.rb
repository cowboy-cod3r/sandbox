#!/opt/apps/ruby/ruby/bin/ruby

i = [0,1,2,3,4]

i.each do |x|
  x = x.to_s
  if (x =~ /[^0,1,4]/)
    puts x
  end
end
