#!/bin/bash

LW_PROFILE=default

usage() { echo "Usage: ./changecompany.sh email companyname" 1>&2; exit 1; }

if [ -z $1 ]
  then
    echo "No user email argument supplied"
    usage
  else
    EMAIL=$1
fi

if [ -z $2 ]
  then
    echo "No company argument supplied"
    usage
  else
    COMPANY=$2
fi

export LW_PROFILE=$LW_PROFILE
echo "Change company for user email ${EMAIL} to ${COMPANY} (v0.1)"
echo "Try to find the user details for the email ${EMAIL}..."
getuserdetails=$(lacework api post api/v2/TeamMembers/search -d '{ "filters" : [ { "expression": "eq", "field": "userName", "value": "'$EMAIL'" } ] }')
lengthofuserdetails=$(echo $getuserdetails | jq 'length')
if [ $lengthofuserdetails -eq 0 ]; then echo "User with that email not found inside the Lacework environment"; exit 1; else echo "User found inside the Lacework environment"; fi
echo "Getting the userGuid for ${EMAIL}..."
userguid=$(echo $getuserdetails | jq -r '.data[].userGuid')
echo "The userGuid is $userguid"
echo "Updating the Company to ${COMPANY}..."
echo lacework api patch api/v2/TeamMembers/$userguid -d '{ "props": { "company" : "Test it" } }'
lacework api patch api/v2/TeamMembers/$userguid -d "{ \"props\": { \"company\" : \"$COMPANY\" } }"
