#!/opt/apps/ruby/ruby/bin/ruby
$:.unshift(File.join(File.dirname(__FILE__),"lib"))

require 'sinatra'
require 'ivv/system/memory/physical'

#class IVV
#  class Monitoring < Sinatra::Application
  
    # routes
    @context = "ivv-monitoring"

    # ==== Description
    # Returns a JSON String containing the memory based
    # on the system
    get "/#{@context}/memory" do
      memory      = IVV::System::Memory::Physical.instance()
      memory.unit = params[:unit] if params[:unit]
      memory.get_physical_memory()
    end

    # ==== Description
    # Returns a JSON String containing a list of valid units
    # for setting the 
    get "/#{@context}/memory/units" do
      memory = IVV::System::Memory::Physical.instance()
      memory.valid_units
    end

#  end
#end

