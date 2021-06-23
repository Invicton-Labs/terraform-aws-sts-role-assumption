#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

IFS='"' read -ra JSON <<< $(cat)
cli_json=$(echo -n "${JSON[3]}" | sed -e 's/__TF_MAGIC_QUOTE_STRING/\"/g')
policy=$(echo -n "${JSON[7]}" | sed -e 's/__TF_MAGIC_QUOTE_STRING/\"/g')
profile=${JSON[11]}

output=`aws sts assume-role --output json --cli-input-json "$cli_json" ${policy:+"--policy" "$policy"} ${profile:+"--profile" "$profile"}`
escaped=$(echo -n "$output" | sed -e 's/\"/\\\"/g' )
escaped_nonewlines=${escaped//$'\n'/}
echo -n "{\"output\": \"$escaped_nonewlines\"}"
