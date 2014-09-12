#!/opt/apps/ruby/ruby/bin/ruby

require 'bundler'

puts Bundler.load
#paths = Bundler.load.specs.map(&:full_gem_path)
#puts paths
#system("ctags -R -f .gemtags #{paths.join(' ')}")
