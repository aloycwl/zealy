// SPDX-License-Identifier: None
pragma solidity 0.8.28;

import {Reward} from "./Reward.sol";
import {USDTMock} from "https://github.com/magape-io/contracts/blob/main/tests/USDTMock.sol";
import {IERC20} from "https://github.com/magape-io/contracts/blob/main/Interface/IERC20.sol";
import {Upgrade} from "https://github.com/magape-io/contracts/blob/main/Proxy/Upgrade.sol";
import {Hashes} from "https://github.com/magape-io/contracts/blob/main/Util/Hashes.sol";

contract Deploy is Hashes {
    constructor() {
        address r = address(new Upgrade(address(new Reward())));

        // For testing use
        address usdt = address(new USDTMock());
        IERC20(usdt).transfer(r, 1e22);

        assembly {
            sstore(0x01, r)
            // Upgrade(mag).mem(APP, adr);
            mstore(
                0x80,
                0xb88bab2900000000000000000000000000000000000000000000000000000000
            )
            // r.signer
            mstore(0x84, APP)
            mstore(0xa4, 0xA34357486224151dDfDB291E13194995c22Df505)
            pop(call(gas(), r, 0x00, 0x80, 0x44, 0x00, 0x00))
            // r.owner
            mstore(0x84, OWO)
            mstore(0xa4, 0xA34357486224151dDfDB291E13194995c22Df505)
            pop(call(gas(), r, 0x00, 0x80, 0x44, 0x00, 0x00))
        }
    }

    function RewardAddress() external view returns (address) {
        assembly {
            mstore(0x00, sload(0x01))
            return(0x00, 0x20)
        }
    }
}
