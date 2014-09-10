#!/bin/bash

# Source the Stack
. ./stacks.sh
. ./utils.sh

# Some local vars
# TODO: this value should be passed in
user=nimdadod

# Loop over each node
for node in $nodes;do
  node_ip=$ip_prefix$node
  log_info "Cleaning up node '$node_ip'..."
  ssh -t $user@$node_ip "echo $user | sudo -i -S -u root /home/nimdadod/clientCleanup.sh --force" 
done
