// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { ISuperfluid } from "@superfluid-finance/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
import { IConstantFlowAgreementV1 } from "@superfluid-finance/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";
import { ISuperToken } from "@superfluid-finance/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol";
import { ISuperfluidToken } from "@superfluid-finance/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidToken.sol";

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

contract SuperfluidDaoToken is ERC20, SuperfluidAdmin {

    // ISuperfluid private _host; // Contrat hôte Superfluid
    // IConstantFlowAgreementV1 private _cfa; // Contrat d'accord de flux constant
    // ISuperToken private _superToken; // Contrat Super Token

    constructor() ERC20("SuperfluidDaoToken", "SFT") SuperfluidAdmin() {
        // _host = ISuperfluid(msg.sender)
        // _cfa = IConstantFlowAgreementV1();
        // _superToke
    }

    function mint(address to, uint256 amount) public onlyAdmin {
        _mint(to, amount);
    }

    function burn(address to, uint256 amount) public onlyAdmin {
        _burn(to, amount);
    }
}
