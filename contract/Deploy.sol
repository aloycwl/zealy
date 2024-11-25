// SPDX-License-Identifier: None
pragma solidity 0.8.28;

import {Reward} from "./Reward.sol";
import {Upgrade} from "https://github.com/magape-io/contracts/blob/main/Proxy/Upgrade.sol";
import {Hashes} from "https://github.com/magape-io/contracts/blob/main/Util/Hashes.sol";

/*** FOR TESTING ONLY ***/
import {USDTMock} from "https://github.com/magape-io/contracts/blob/main/tests/USDTMock.sol";

contract Deploy is Hashes {
    address payable public adr;

    constructor() payable {
        bytes32 owner;
        bytes32 signer;

        assembly {
            owner := origin()
            signer := 0xA34357486224151dDfDB291E13194995c22Df505
        }

        Upgrade(adr = payable(address(new Upgrade(address(new Reward()))))).mem(APP, signer);
        Upgrade(adr).mem(OWO, owner);

        /*** FOR TESTING ONLY ***/
        USDTMock(address(new USDTMock())).transfer(adr, 0xd3c21bcecceda1000000);
    }
}
