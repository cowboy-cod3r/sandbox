# Required Libraries
require 'ruby-enum'

class MemoryUnits
  include Ruby::Enum
  define :TERABYTES,  "TB"
  define :GIGABYTES,  "GB"
  define :MEGABYTES,  "MB"
  define :KILOBYTES,  "KB"
  define :BYTES,      "B"
end