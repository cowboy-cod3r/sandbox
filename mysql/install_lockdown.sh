#!/bin/bash

# Set some variables
declare -r root="root"
declare -r old_pwd="password"
declare -r new_pwd="password"

# SQL Statements to execute
declare -p statements=("UPDATE mysql.user SET Password=PASSWORD('${old_pwd}') WHERE User='${root}'" \
                       "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')" \
                       "DELETE FROM mysql.user WHERE User=''" \
                       "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'" \
                       "FLUSH PRIVILEGES")


echo "INFO: Securing MySQL"

for sql in "${statements[@]}";do
  mysql -u "${root}" --password="${new_pwd}" -e "${sql}"
  if [[ $? -ne 0 ]]; then
    echo "ERROR: The command '${sql}' did not execute successfully."
    exit 1
  fi
done

