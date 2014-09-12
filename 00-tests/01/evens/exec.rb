#!/opt/apps/ruby/ruby/bin/ruby

range   = 1..100
exclude = [2, 100]

range.each do |i|
  if i.even? && !exclude.include?(i)
    puts i
  end
end

