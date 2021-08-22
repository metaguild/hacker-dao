set -e
NETWORK=testnet
OWNER=agency.$NETWORK

COUNCIL_ACC=agency.testnet
DAO_NAME=hackr.agency.testnet

##Change NODE_ENV between mainnet, testnet and betanet
export NODE_ENV=testnet

#DAO Policy
export POLICY='{
  "roles": [
    {
      "name": "council",
      "kind": { "Group": ["agency.testnet", "metabuild.testnet", "hackathon.testnet"]
      },
      "permissions": [ "*:*" ],
      "vote_policy": { "weight_kind": "RoleWeight", "quorum": "0", "threshold": [ 1,8 ] }
    },
    {
      "name": "hacker",
      "kind": { "Group": ["hackr.testnet"]
      },
      "permissions": [ "*:*" ],
      "vote_policy": { "weight_kind": "RoleWeight", "quorum": "0", "threshold": [ 1,2 ] }
    }
  ],
  "default_vote_policy": { "weight_kind": "RoleWeight", "quorum": "0", "threshold": [ 1,2 ] },
  "proposal_bond": "1000000000000000000000000",
  "proposal_period": "604800000000000",
  "bounty_bond": "1000000000000000000000000",
  "bounty_forgiveness_period": "86400000000000"
}'

#Args for creating DAO in sputnik-factory2
ARGS=`echo "{\"config\":  {\"name\": \"testpolicy\", \"purpose\": \"Test DAO Policy\", \"metadata\":\"\"}, \"policy\": $POLICY" | base64`
read input
# Call sputnik factory for deploying new dao with custom policy
near call agency.testnet create "{\"name\": \"$DAO_NAME\", \"args\": \"$ARGS\"}" --accountId $COUNCIL_ACC --amount 5 --gas 150000000000000
near view $DAO_NAME.$OWNER get_policy