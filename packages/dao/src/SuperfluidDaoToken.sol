// SPDX-License-Identifier: AGPLv3
pragma solidity ^0.8.0;

import {SuperTokenBase} from "custom-supertokens/base/SuperTokenBase.sol";

address constant SUPER_TOKEN_FACTORY = 0x94f26B4c8AD12B18c12f38E878618f7664bdcCE2;

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

contract SuperfluidDaoToken is SuperTokenBase, SuperfluidAdmin {
    constructor() {
        // _initialize(SUPER_TOKEN_FACTORY, "SuperfluidDaoToken", "SDT");
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balanceOf(account);
    }

    function mint(address to, uint256 amount) public onlyAdmin {
        _mint(to, amount, "");
    }

    function burn(address to, uint256 amount) public onlyAdmin {
        _burn(to, amount, "");
    }
}
