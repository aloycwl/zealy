// SPDX-License-Identifier: None
pragma solidity 0.8.28;

import {Reward} from "./Reward.sol";
import {IERC20} from "https://github.com/magape-io/contracts/blob/main/Interface/IERC20.sol";
import {Upgrade} from "https://github.com/magape-io/contracts/blob/main/Proxy/Upgrade.sol";
import {Hashes} from "https://github.com/magape-io/contracts/blob/main/Util/Hashes.sol";

contract Deploy is Hashes {
    address public RewardAddress;

    constructor() {
        (bytes32[] memory arr1, bytes32[] memory arr2) = (
            new bytes32[](2),
            new bytes32[](2)
        );

        (arr1[0], arr1[1], arr2[0], arr2[1], RewardAddress) = (
            APP,
            OWO,
            0x000000000000000000000000A34357486224151dDfDB291E13194995c22Df505, // Signer
            0x000000000000000000000000A34357486224151dDfDB291E13194995c22Df505, // Owner
            address(new Upgrade(address(new Reward())))
        );

        Upgrade(payable(RewardAddress)).mem(arr1, arr2);
    }
}
