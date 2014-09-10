#!/opt/apps/ruby/ruby/bin/ruby

images = Dir.glob("/opt/issinc/ivv/tmp/test/*.png")
images.each do |image|
  puts image
end
