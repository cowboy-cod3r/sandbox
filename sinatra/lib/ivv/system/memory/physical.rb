#$:.unshift(File.join(File.dirname(__FILE__),"..","..","..","..","lib"))

require 'singleton'
require 'json'

class IVV
  class Monitoring
    class Memory

      # == Description
      # This class represents the physical memory on a given
      # machine.  Presently this class only support Linux.
      class Physical

        # Modules
        include Singleton

        # Accessors
        attr_reader :total, :used, :free, :buffers, :cached
        attr_reader :buffers_cached_used, :buffers_cached_free
        attr_accessor :cmd, :errors, :unit

        # ==== Description
        # Constructor
        def initialize()
        end

        # ==== Description
        # Builds the command
        private
          def build_command()
            free    = "free"
            @unit ||= "MB"
            case @unit.upcase
            when "TB"
              switch = "--tera"
            when "GB"
              switch = "-g"
            when "MB" 
              switch = "-m"
            when "KB" 
              switch = "-k"
            when "B"
              switch = "-b"
            else
              @unit  = "MB"        
              switch = "-m"
            end
            return free + " " + switch
          end


        # ==== Description
        # Retrieves and sets memory information
        #
        # ==== Returns
        # A json string of this object
        public
          def get_physical_memory()
            # get the memory
            cmd = build_command()
            total_memory = `#{cmd}`
            puts $?.exitstatus

            # Turn it into an array
            ary = total_memory.split("\n")

            # Parse out the data
            ary.each_with_index do |line,line_index|
              next if line_index.to_s =~ /[0,3]/
              line_ary = line.split("\s")

              case line_index
              when 1
                line_ary.each_with_index do |value,value_index|
                  next if value_index =~ /[0,4]/
                  case value_index
                  when 1
                    @total = value
                  when 2
                    @used = value
                  when 3
                    @free = value
                  when 5
                    @buffers = value
                  when 6
                    @cached = value
                  end
                end
              when 2
                line_ary.each_with_index do |value,value_index|
                  next if value_index =~ /[0,1]/
                  case value_index
                  when 2
                    @buffers_cached_used = value
                  when 3
                    @buffers_cached_free = value
                  end 
                end 
              end
            end
            return self.to_json
          end

        # ==== Description
        # Convert the object to a JSON string
        public
          def to_json(*a)
            {
              "json_class"           => self.class.name,
              "data"                 => 
              {
                "unit"                 => @unit,
                "total"                => @total,
                "used"                 => @used,
                "free"                 => @free,
                "buffers"              => @buffers,
                "cached"               => @cached,
                "buffers_cached_used"  => @buffers_cached_used,
                "buffers_cached_free"  => @buffers_cached_free
              }
            }.to_json(*a)
          end

        # ==== Description
        # Returns a list of valid units in json format
        public
          def valid_units(*a)
            JSON.generate(MemoryUnits.values)
          end
      end
    end
  end
end
