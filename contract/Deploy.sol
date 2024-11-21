// SPDX-License-Identifier: None
pragma solidity 0.8.28;

import {Reward} from "./Reward.sol";
import {Upgrade} from "https://github.com/magape-io/contracts/blob/main/Proxy/Upgrade.sol";
import {Hashes} from "https://github.com/magape-io/contracts/blob/main/Util/Hashes.sol";

contract Deploy is Hashes {
    address public RewardAddress;

    constructor() {
        RewardAddress = address(new Upgrade(address(new Reward())));

        Upgrade(payable(RewardAddress)).mem(
            APP, // Signer
            0x000000000000000000000000A34357486224151dDfDB291E13194995c22Df505
        );
        Upgrade(payable(RewardAddress)).mem(
            OWO, // Owner
            0x000000000000000000000000A34357486224151dDfDB291E13194995c22Df505
        );
    }
}
