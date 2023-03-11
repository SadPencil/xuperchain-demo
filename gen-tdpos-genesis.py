#!/usr/bin/env python3
import json
import sys

genesis_conf = {
    "version": "1",
    "predistribution": [
        # {
        #     "address": "TeyyPLpp9L7QAcxHangtcHTu7HUZ6iydY",
        #     "quota": "100000000000000000000"
        # }
    ],
    "maxblocksize": "128",
    "award": "1000000",
    "decimals": "8",
    "award_decay": {
        "height_gap": 31536000,
        "ratio": 1
    },
    "gas_price": {
        "cpu_rate": 1000,
        "mem_rate": 1000000,
        "disk_rate": 1,
        "xfee_rate": 1
    },
    "new_account_resource_amount": 1000,
    "genesis_consensus": {
        "name": "tdpos",
        "config": {
            "timestamp": "1559021720000000000",
            "proposer_num": "2",
            "period": "3000",
            "alternate_interval": "3000",
            "term_interval": "6000",
            "block_num": "20",
            "vote_unit_price": "1",
            "init_proposer": {
                "1": [
                    # "TeyyPLpp9L7QAcxHangtcHTu7HUZ6iydY",
                    # "SmJG3rH2ZzYQ9ojxhbRCPwFiE9y6pD1Co"
                ]
            },
            # "init_proposer_neturl": {
            #     "1": [
            #         "/ip4/127.0.0.1/tcp/47101/p2p/Qmf2HeHe4sspGkfRCTq6257Vm3UHzvh2TeQJHHvHzzuFw6e",
            #         "/ip4/127.0.0.1/tcp/47102/p2p/QmQKp8pLWSgV4JiGjuULKV1JsdpxUtnDEUMP8sGaaUbwVL"
            #     ]
            # }
        }
    }
}

if __name__ == '__main__':
    for i in range(1, len(sys.argv)):
        addr = sys.argv[i]
        genesis_conf["predistribution"].append({
            "address": addr,
            "quota": "100000000000000000000",
        })

    for i in range(1, len(sys.argv)):
        addr = sys.argv[i]
        genesis_conf["genesis_consensus"]["config"]["init_proposer"]["1"].append(
            addr
        )

    print(json.dumps(genesis_conf))
