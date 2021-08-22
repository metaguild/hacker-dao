set -e
NETWORK=mainnet
OWNER=agency.$NETWORK
MASTER_ACC=$OWNER
CONTRACT_ACC=hackr.$MASTER_ACC
TOKEN_ACC=token.agency.testnet
TREASURY_ACC=treasury.$MASTER_ACC

COUNCIL_ACC=agency.$NETWORK

KEY_TO_DELETE="ed25519%3A2KUeDQjCkAhmrb8LSN7TjHdyZRevDU4dR37JRxHvjZqR"

export NODE_ENV=$NETWORK

near keys $CONTRACT_ACC
echo "¡IMPORTANT!"
echo "Modify the KEY_TO_DELETE parameter in delete_keys with the public_key that is going to be deleted. Are you ready? Ctrl-C to cancel"
read input
echo "¡REMEMBER"
echo "Once you delete all access keys the account will not be possible to be deleted or redeployed. Ctrl-C to cancel"
read input
near delete-key $CONTRACT_ACC $KEY_TO_DELETE
echo "Keys succesfully deleted"