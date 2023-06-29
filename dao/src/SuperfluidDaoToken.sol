// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.0;

import {SuperTokenBase} from "../custom-supertokens/contracts/base/SuperTokenBase.sol";

address constant SUPER_TOKEN_FACTORY = 0x0422689cc4087b6B7280e0a7e7F655200ec86Ae1;

contract SuperfluidAdmin {
    address private _admin;

    constructor() {
        _admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == _admin, "SuperfluidAdmin/NotAuthorized");
        _;
    }

    function setAdmin(address admin) public onlyAdmin {
        _admin = admin;
    }
}

contract SuperfluidDaoToken is  SuperfluidAdmin {

    constructor() {
		_initialize(SUPER_TOKEN_FACTORY, "SuperfluidDaoToken", "SDT");
    }

	function mint(address to, uint256 amount) public onlyAdmin {
        _mint(to, amount);
    }

    function burn(address to, uint256 amount) public onlyAdmin {
        _burn(to, amount);
    }
}
