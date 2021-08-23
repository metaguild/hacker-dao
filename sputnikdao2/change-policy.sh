#!/bin/bash
set -e

REPL=$(cat <<-END
const accountId = "agency.near";
const contractName = "hack.sputnik-dao.near";
const account = await near.account(accountId);
const args = {"proposal": {"description": "Change Policy", "kind": {"ChangePolicy": {
  "policy": {
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
        "threshold": [1,8]
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
      "vote_policy": {}
    }
  ],
  "default_vote_policy": {
    "weight_kind": "RoleWeight",
    "quorum": "0",
    "threshold": [1,2]
  },
  "proposal_bond": "10000000000000000000000",
  "proposal_period": "604800000000000",
  "bounty_bond": "1000000000000000000000000",
  "bounty_forgiveness_period": "86400000000000"
}}}}};

account.signAndSendTransaction(
    contractName,
    [
        nearAPI.transactions.functionCall("add_proposal", args, 20000000000000, "10000000000000000000000000"),
    ]);
END)

echo $REPL | near repl