// SPDX-License-Identifier: None
pragma solidity 0.8.28;

import {Ownable} from "./Ownable.sol";
import {IERC20} from "./IERC20.sol";
import {ECDSA} from "./ECDSA.sol";

contract Reward is Ownable {
    address public tokenAddress;
    address public signer;

    function reward(bytes calldata c) external {
        (uint256 amount, uint bid, uint8 v, bytes32 r, bytes32 s) = ECDSA.diffuser(c);

        bytes32 hash = ECDSA.hashing(msg.sender, amount, bid);

        require(ECDSA.recover(hash, v, r, s) == msg.sender, "sig failed");

        IERC20(tokenAddress).transfer(msg.sender, amount);
    }

    function setTokenAddress(address _newToken) external onlyOwner {
        tokenAddress = _newToken;
    }

    function removeLiquid(uint256 _amount) external onlyOwner {
        IERC20(tokenAddress).transfer(msg.sender, _amount);
    }

    function tryDiffuser(bytes memory _c)
        public
        pure
        returns (
            uint256,
            uint256,
            uint8,
            bytes32,
            bytes32
        )
    {
        return ECDSA.diffuser(_c);
    }

    function setSigner(address _newSigner) external onlyOwner {
        signer = _newSigner;
    }
}
