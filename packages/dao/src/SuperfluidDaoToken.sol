// SPDX-License-Identifier: UNLICENSED
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
    constructor() {}

    /// @dev Upgrades the super token with the factory, then initializes.
    /// @param factory super token factory for initialization
    /// @param name super token name
    /// @param symbol super token symbol
    function initialize(
        address factory,
        string memory name,
        string memory symbol
    ) external onlyAdmin {
        _initialize(factory, name, symbol);
    }

    function mint(address to, uint256 amount) public onlyAdmin {
        _mint(to, amount, "");
    }

    function burn(address to, uint256 amount) public onlyAdmin {
        _burn(to, amount, "");
    }
}
