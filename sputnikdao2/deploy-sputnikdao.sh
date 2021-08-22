set -e
MASTER_ACC=agency.near
CONTRACT_ACC=metabuild.$MASTER_ACC

export NODE_ENV=mainnet
export POLICY='{
  "roles": [
    {
      "name": "all",
      "kind": "Everyone",
      "permissions": [
        "*:AddProposal"
      ],
      "vote_policy": {}
    },
    {
      "name": "council",
      "kind": {
        "Group": [
          "hack.near",
          "agency.near",
          "tjtc.near",
          "metabuild.near"
        ]
      },
      "permissions": [
        "*:*"
      ],
      "vote_policy": {
        "weight_kind": "RoleWeight",
        "quorum": "0",
        "threshold": "1"
      }
    },
    {
      "name": "hacker",
      "kind": {
        "Group": [
          "tjtc.near",
          "create.near",
          "devs.near"
        ]
      },
      "permissions": [
        "*:*"
      ],
      "vote_policy": {
        "weight_kind": "RoleWeight",
        "quorum": "0",
        "threshold": [
          1,
          2
        ]
      }
    }
  ],
  "default_vote_policy": {
    "weight_kind": "RoleWeight",
    "quorum": "0",
    "threshold": [
        1,
        2
    ]
  },
  "proposal_bond": "10000000000000000000000",
  "proposal_period": "604800000000000",
  "bounty_bond": "1000000000000000000000000",
  "bounty_forgiveness_period": "86400000000000"
}'

near create-account $CONTRACT_ACC --masterAccount $MASTER_ACC --initialBalance 20
near deploy --wasmFile=res/sputnikdao2.wasm --initFunction "new" --initArgs '{"config": {"name": "metabuild", "purpose": "Hackathon DAO", "metadata":""}, "policy": '$POLICY'}' --accountId $CONTRACT_ACC
near view $CONTRACT_ACC get_policy
echo "DAO succesfully deployed!"

##redeploy only
#near deploy $CONTRACT_ACC --wasmFile=res/sputnikdao2.wasm  --accountId $MASTER_ACC

#save last deployment 
#cp ./res/sputnikdao2.wasm ./res/sputnikdao2.`date +%F.%T`.wasm
#date +%F.%T