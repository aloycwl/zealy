// SPDX-License-Identifier: None
pragma solidity 0.8.28;

import {Reward} from "./Reward.sol";
import {Upgrade} from "https://github.com/magape-io/contracts/blob/main/Proxy/Upgrade.sol";
import {Hashes} from "https://github.com/magape-io/contracts/blob/main/Util/Hashes.sol";

contract Deploy is Hashes {
    address payable public adr;

    constructor() payable {
        Upgrade(adr = payable(address(new Upgrade(address(new Reward()))))).mem(
            APP,
            0x000000000000000000000000b1d27563893d716fb7677eeffbc06c14d2da66e4
        );
        Upgrade(adr).mem(
            OWO,
            0x0000000000000000000000008b050460660f05cfa1b9a827c55fcea53c2a0474
        );
    }
}
