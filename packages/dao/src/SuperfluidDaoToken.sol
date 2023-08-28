// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {SuperTokenBase} from "custom-supertokens/base/SuperTokenBase.sol";
import {ISuperToken} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol";
import {
    SuperTokenV1Library
} from "@superfluid-finance/ethereum-contracts/contracts/apps/SuperTokenV1Library.sol";


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
error Unauthorized();


contract SuperfluidDaoToken is SuperTokenBase, SuperfluidAdmin {
    using SuperTokenV1Library for ISuperToken;
    constructor() {}

    function initialize(
        address factory,
        string memory name,
        string memory symbol
    ) external onlyAdmin {
        _initialize(factory, name, symbol);
    }

    function createFlowIntoContract(ISuperToken token, int96 flowRate) external{
        token.createFlowFrom(msg.sender, address(this), flowRate);
    }

    /// @notice Update an existing stream being sent into the contract by msg sender.
    /// @dev This requires the contract to be a flowOperator for the msg sender.
    /// @param token Token to stream.
    /// @param flowRate Flow rate per second to stream.
    function updateFlowIntoContract(ISuperToken token, int96 flowRate) external onlyAdmin(){
        token.updateFlowFrom(msg.sender, address(this), flowRate);
    }

    /// @notice Delete a stream that the msg.sender has open into the contract.
    /// @param token Token to quit streaming.
    function deleteFlowIntoContract(ISuperToken token) external onlyAdmin{
        token.deleteFlow(msg.sender, address(this));
    }

    function mint(address to, uint256 amount) public onlyAdmin {
        _mint(to, amount, "");
    }

    function burn(address to, uint256 amount) public onlyAdmin {
        _burn(to, amount, "");
    }
    
}
