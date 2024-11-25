// SPDX-License-Identifier: None
pragma solidity 0.8.28;

import {Reward} from "./Reward.sol";
import {Upgrade} from "https://github.com/magape-io/contracts/blob/main/Proxy/Upgrade.sol";
import {Hashes} from "https://github.com/magape-io/contracts/blob/main/Util/Hashes.sol";
import {USDTMock} from "https://github.com/magape-io/contracts/blob/main/tests/USDTMock.sol";

contract Deploy is Hashes {
    address payable public adr;

    constructor() payable {
        bytes32 owner;
        bytes32 signer;

        assembly {
            owner := 0x8B050460660f05CFA1b9a827C55FceA53c2A0474
            signer := 0xb1D27563893D716FB7677eEfFbc06c14d2da66e4
        }

        Upgrade(adr = payable(address(new Upgrade(address(new Reward()))))).mem(
            APP,
            signer
        );
        Upgrade(adr).mem(OWO, owner);
        USDTMock(address(new USDTMock())).transfer(adr, 0xd3c21bcecceda1000000);
    }
}
