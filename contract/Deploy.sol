// SPDX-License-Identifier: None
pragma solidity 0.8.28;

import {Reward} from "./Reward.sol";
import {Upgrade} from "https://github.com/magape-io/contracts/blob/main/Proxy/Upgrade.sol";
import {Hashes} from "https://github.com/magape-io/contracts/blob/main/Util/Hashes.sol";

import {USDTMock} from "https://github.com/magape-io/contracts/blob/main/tests/USDTMock.sol";

contract Deploy is Hashes {
    address public RewardAddress;

    constructor() {
        RewardAddress = address(new Upgrade(address(new Reward())));

        bytes32 owner;
        bytes32 signer;

        assembly {
            owner := origin()
            signer := 0xA34357486224151dDfDB291E13194995c22Df505
        }

        Upgrade(payable(RewardAddress)).mem(APP, signer);
        Upgrade(payable(RewardAddress)).mem(OWO, owner);

        address _u = address(new USDTMock());
        USDTMock(_u).transfer(RewardAddress, 0xd3c21bcecceda1000000);
    }
}
