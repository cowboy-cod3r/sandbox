#!/opt/apps/ruby/ruby/bin/ruby

require 'rest-client'
require 'json'

uri = "https://172.30.12.53:8443/workflow-service"
resource = RestClient::Resource.new(uri, :headers => { :Authorization => "Bearer npe-iss-rbac-admin" })
templates = JSON.parse(resource['processtemplate'].get())['ProcessTemplateList']
definitions = JSON.parse(resource['processdefinition'].get())
#types = []
#templates.each do |type_json|
#  if type_json["ObjectID"] == "ac44b387-7a95-4072-b6c7-7749e710a2ab"
#    puts type_json["Type"]
#    break
#  end
  #type_hash = type_json.select{ |k,v| k == "Type" }
  #types.push(type_hash["Type"])
#end
orig = File.read("/home/sean.humbarger/workspace/chef-repo/cookbooks/core_workflow_service/jarhub_files/default/01_def_default.json")
orig = JSON.parse(orig)
puts orig
puts
puts
puts
puts definitions
definitions.each do |defs|
  defs = JSON.parse(defs["PayloadJSON"])
  puts defs
  if orig === defs
    puts "matched"
  end
end
