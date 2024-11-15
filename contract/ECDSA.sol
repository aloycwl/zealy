// SPDX-License-Identifier: None
pragma solidity 0.8.28;

library ECDSA {
    function diffuser(bytes memory c)
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
        assembly {
            return(add(c, 0x20), 0xa0)
        }
    }

    function hashing(
        address adr,
        uint256 bid,
        uint256 amt
    ) public pure returns (bytes32) {
        assembly {
            mstore(0x80, adr)
            mstore(0xa0, bid)
            mstore(0xc0, amt)
            mstore(0x00, keccak256(0x80, 0x60))
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
