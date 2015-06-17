#!/usr/bin/ruby

require 'rest-client'
require 'json'

images            = RestClient.get('http://172.30.14.211:4242/product-env/stacks/5cf858a5-5088-4b41-80c7-3155fb8d1936/nodes/172.30.11.249/images')
images = JSON.parse(images)

if (images.nil? || images.empty?)
  raise(RuntimeError, 'The call returned no data')
end

images.each do |image|
  # Set a default docker socket to use to help generate the full name
  docker_hub_socket = '172.30.14.209'

  # Add a command and some options since we don't have any with our images in the database
  #image['command'] = '/bin/bash'
  #image['options'] = []
  #image['options'] << "--env=\"DOCKER_HOST_IP=$(hostname -I | cut -f 1 -d ' ')\""
  #image['options'] << "--env=\"REDIRECT_NON_SSL=true\""
  #image['options'] << "--name=\"centos7_httpd\""
  #image['options'] << "--volume=\"/opt/issinc/global/logs/httpd:/var/log/httpd\""
  #image['options'] << "--volume=\"/opt/issinc/global/certs:/opt/issinc/global/certs\""

  # Initialize the start and end of the command
  command_prefix = "docker run"
  command_suffix = ''
  final_command  = "%s %s"

  # Set the identifier
  if (image['namespace'].nil? || image[:tag].nil?)
    raise(RuntimeError, 'You must supply a namespace and a tag')
  end
  identifier     = docker_hub_socket + '/' + image['namespace'] + ':' + image['tag'] 
  command_suffix = identifier

  # Get any options if there are any
  # This is where any options for the docker run command are assembled
  if (image.has_key?('options') && image['options'].kind_of?(Array) && !image['options'].empty?)
    options        = image['options'].join(' ')
    command_prefix = command_prefix + ' ' + options
  end

  # Get the trailing docker run command if one is provided
  # This where we set the command to be executed on the running container if
  # specified.
  if (image.has_key?('command') && image['command'].kind_of?(String) && !image['command'].strip.empty?)
    command        = image['command']
    command_suffix = command_suffix + ' ' + command
  end

  # Put it all together
  final_command = final_command % [command_prefix, command_suffix]

  # Output the command
  puts final_command
end
