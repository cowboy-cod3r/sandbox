#!/opt/apps/ruby/ruby/bin/ruby

require 'yaml'

# Serialize it via yaml
unserialized = YAML::load_file("/opt/issinc/ivv/conf/override-hosts.yml")
serialized   = YAML::dump(unserialized)
puts serialized

