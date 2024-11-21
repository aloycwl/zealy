// SPDX-License-Identifier: None
pragma solidity 0.8.28;

import {Hashes} from "https://github.com/magape-io/contracts/blob/main/Util/Hashes.sol";
import {Ownable} from "https://github.com/magape-io/contracts/blob/main/Util/Ownable.sol";
import {IERC20} from "https://github.com/magape-io/contracts/blob/main/Interface/IERC20.sol";
import {ECDSA} from "https://github.com/magape-io/contracts/blob/main/Util/ECDSA.sol";

contract Reward is Ownable, ECDSA {
    function reward(bytes memory c) external {
        uint256 a;
        uint256 b;
        uint256 n;
        address t;
        uint8 v;
        bytes32 r;
        bytes32 s;

        assembly {
            n := mload(add(c, 0x20))
            t := n
            a := mload(add(c, 0x40))
            b := mload(add(c, 0x60))
            v := mload(add(c, 0x80))
            r := mload(add(c, 0xa0))
            s := mload(add(c, 0xc0))
        }

        isVRS(b, a, n, v, r, s);

        IERC20(t).transfer(msg.sender, a);
    }

    function removeLiquid(uint256 a, address t) external onlyOwner {
        IERC20(t).transfer(msg.sender, a);
    }
}
