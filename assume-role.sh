#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

IFS='"' read -ra JSON <<< $(cat)
external_id=${JSON[3]}
policy=${JSON[7]}
profile=${JSON[11]}
role_arn=${JSON[15]}
session_duration=${JSON[19]}
session_name=${JSON[23]}

if ! [ -z "$external_id" ]; then
    external_id_key="--external-id"
fi
if ! [ -z "$policy" ]; then
    policy_key="--policy"
    policy=$(echo -n "$policy" | sed -e 's/__TF_MAGIC_QUOTE_STRING/\\\"/g')
fi
echo ""
output=$(aws sts assume-role --role-arn "$role_arn" --role-session-name "$session_name" $external_id_key $external_id $policy_key "$policy" --duration-seconds $session_duration --profile "$profile" --output json)
escaped=$(echo -n "$output" | sed -e 's/\"/\\\"/g' )
escaped_nonewlines=${escaped//$'\n'/}
echo -n "{\"output\": \"$escaped_nonewlines\"}"
