// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SuperFluidAdmin {
    address private _admin;

    constructor() {
        _admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == _admin, "SuperFluidAdmin/NotAuthorized");
        _;
    }

    function setAdmin(address admin) public onlyAdmin {
        _admin = admin;
    }
}

contract SuperFluidToken is ERC20, SuperFluidAdmin {
    constructor() ERC20("SuperFluidToken", "SFT") SuperFluidAdmin() {}

    function mint(address to, uint256 amount) public onlyAdmin {
        _mint(to, amount);
    }
}
