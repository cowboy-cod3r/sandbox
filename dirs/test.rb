#!/opt/apps/ruby/ruby/bin/ruby

# Example on how to loop over all files in a directory that end with .png

images = Dir.glob("/opt/issinc/ivv/tmp/test/*.png")
images.each do |image|
  puts image
end
