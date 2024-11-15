// SPDX-License-Identifier: None
pragma solidity 0.8.28;

library ECDSA {
    function diffuser(bytes memory c)
        public
        pure
        returns (
            uint256,
            uint8,
            bytes32,
            bytes32
        )
    {
        assembly {
            mstore(0x80, mload(add(c, 0x20)))
            mstore(0xa0, mload(add(c, 0x40)))
            mstore(0xc0, mload(add(c, 0x60)))
            mstore(0xe0, byte(0, mload(add(c, 0x80))))
            return(0x80, 0x80)
        }
    }

    function hashing(uint256 amt, uint256 nid) public pure returns (bytes32) {
        assembly {
            mstore(0x80, amt)
            mstore(0xa0, nid)
            mstore(0x00, keccak256(0x80, 0x40))
            return(0x00, 0x20)
        }
    }

    function recover(
        bytes32 hsh,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public pure returns (address) {
        return (ecrecover(hsh, v, r, s));
    }
}
