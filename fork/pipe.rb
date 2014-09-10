#!/opt/apps/ruby/ruby/bin/ruby

require 'singleton'

class IvvPipe
  include Singleton

  attr_accessor :reader, :writer

  private
    def initialize()
      @reader, @writer = IO.pipe()
    end

end
