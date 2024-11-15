// SPDX-License-Identifier: None
pragma solidity 0.8.28;

import {Ownable} from "./Ownable.sol";
import {IERC20} from "./IERC20.sol";
import {ECDSA} from "./ECDSA.sol";

contract Reward is Ownable {
    mapping(address => uint256) public userNonce;
    address public tokenAddress;

    function reward(bytes memory c) external {
        (uint256 amount, uint8 v, bytes32 r, bytes32 s) = ECDSA.diffuser(c);

        bytes32 hash = ECDSA.hashing(amount, userNonce[msg.sender]);

        require(ECDSA.recover(hash, v, r, s) == msg.sender, "sig failed");

        ++userNonce[msg.sender];

        IERC20(tokenAddress).transfer(msg.sender, amount);
    }

    function setTokenAddress(address _newToken) external onlyOwner {
        tokenAddress = _newToken;
    }

    function removeLiquid(uint256 amount) external onlyOwner {
        IERC20(tokenAddress).transfer(msg.sender, amount);
    }

    function tryDiffuser(bytes memory c)
        public
        pure
        returns (
            uint256,
            uint8,
            bytes32,
            bytes32
        )
    {
        return ECDSA.diffuser(c);
    }
}
