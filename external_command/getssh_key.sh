#!bin/bash

curl -X GET \
-H "Authorization: Bearer ${do_token_rebrain}" \
"https://api.digitalocean.com/v2/account/keys"
