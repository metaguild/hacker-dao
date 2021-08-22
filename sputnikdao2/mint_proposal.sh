set -e
NETWORK=testnet
OWNER=agency.$NETWORK
MASTER_ACC=$OWNER
CONTRACT_ACC=hackr.$MASTER_ACC
TOKEN_ACC=token.agency.testnet
#TREASURY_ACC=treasury.$MASTER_ACC <--Write it directly in the ARGS_MINT

COUNCIL_ACC=agency.$NETWORK

export NODE_ENV=$NETWORK

ARGS_MINT=`echo '{"account_id": "treasury.agency.testnet", "amount": "20000000000000000000000000000000"}' | base64`

near call $CONTRACT_ACC add_proposal "{\"proposal\": {\"description\": \"Cheddar Genesis\", \"kind\": {\"FunctionCall\": {\"receiver_id\": \"$TOKEN_ACC\", \"actions\": [{\"method_name\": \"mint\", \"args\": \"$ARGS_MINT\", \"deposit\": \"1\", \"gas\": \"20000000000000\"}]}}}}" --accountId $COUNCIL_ACC --amount 1
near view $CONTRACT_ACC get_proposals '{"from_index": 0, "limit": 10}'