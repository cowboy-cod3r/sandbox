#!/opt/apps/ruby/ruby/bin/ruby

cmd_ary = ["/opt/issinc/ivv/features/topic-builder/tb.feature","-q","-f","json","-o","/opt/issinc/ivv/reports"]
#cmd_str = "-t arg1,arg2,arg3 -x something"
cmd_str = ""
str_to_ary = cmd_str.split(" ")
str_to_ary = cmd_ary.zip(str_to_ary).flatten().compact()
puts str_to_ary
puts str_to_ary.inspect
