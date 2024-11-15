// SPDX-License-Identifier: None
pragma solidity 0.8.28;

import {Reward} from "./Reward.sol";
import {USDTMock} from "./USDTMock.sol";
import {IERC20} from "./IERC20.sol";

contract TestDeploy {
    address public RewardAddress;

    constructor() {
        RewardAddress = address(new Reward());
        address usdt = address(new USDTMock());
        Reward(RewardAddress).setTokenAddress(usdt);
        Reward(RewardAddress).setSigner(0xA34357486224151dDfDB291E13194995c22Df505);
        IERC20(usdt).transfer(RewardAddress, 1e22);
    }
}