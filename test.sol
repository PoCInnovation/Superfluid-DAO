// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { IVestingPlatform } from "./IVestingPlatform.sol";

contract VestingPlatform is IVestingPlatform {
    mapping(address => VestingData[]) private _vestings;
    address[] private _vestingBeneficiaries;
    address private _feeTokenAddress;
    uint256 private _fee;

    constructor(address initialFeeToken, uint256 initialFee) {
        if (initialFeeToken == address(0)) {
            revert WrongVestingToken();
        }
        _feeTokenAddress = initialFeeToken;
        _fee = initialFee;
    }

    function vestingAmount(uint256 amount, uint64 startTimestamp, uint64 endTimestamp, uint256 amountClaimed) external view override returns (uint256 value) {
        if (block.timestamp >= endTimestamp) {
            return amount - amountClaimed;
        } else if (block.timestamp <= startTimestamp) {
            return 0;
        } else {
            uint256 vestedAmount = amount * (block.timestamp - startTimestamp) / (endTimestamp - startTimestamp);
            return vestedAmount - amountClaimed;
        }
    }
}
