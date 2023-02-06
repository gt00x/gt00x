#!/bin/bash

log_file=$1

while read line; do
    # Split line into fields using space as a delimiter
    IFS=' ' read -a fields <<< "$line"

    # Convert  to ISO date format using the -j option of the BSD date command
    date=$(date -u -j -f "%y.%j.%H.%M.%S" ${fields[0]} +"%F %T")

    # Get mili seconds
    mili=$(echo ${fields[0]}|cut -f 6 -d ".")

    # Print the first field (converted date)
    echo -n "$date.$mili "

    # Print the rest of the fields as they are
    echo "${fields[@]:1}"
done < "$log_file"

