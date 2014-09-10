#!/opt/apps/ruby/ruby/bin/ruby

          @override_props_dir  = nil
          
          # Set override directory if applicable
          found = false
          ARGV.each do |arg|
            
            if ! found
              if arg.downcase == "-l" || arg.downcase == "--logconfdir"
                found = true
                next
              end
            else
              @override_props_dir = arg
              break
            end
          end
          
          @override_props_dir  = File.join("/opt","issinc","ivv","conf") if @override_props_dir.nil?

puts @override_props_dir
