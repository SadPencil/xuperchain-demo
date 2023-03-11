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
        "name": "pow",
        "config": {
            "defaultTarget": "545259519",
            "adjustHeightGap": "5",
            "expectedPeriod": "15",
            "maxTarget": "486604799"
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

    print(json.dumps(genesis_conf))
