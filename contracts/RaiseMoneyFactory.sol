// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./RaiseMoney.sol";

contract RaiseMoneyFactory {
    struct DeployedContracts {
        RaiseMoney contractAddress;
        address manager;
    }
    DeployedContracts[] public deployedContracts;

    function getDeployedContracts()
        public
        view
        returns (DeployedContracts[] memory)
    {
        return deployedContracts;
    }

    function deployRaiseMoney(string memory _description, uint256 _amountNeeded)
        public
    {
        RaiseMoney raiseMoney = new RaiseMoney(
            payable(msg.sender),
            _description,
            _amountNeeded
        );
        DeployedContracts memory _deployedContract = DeployedContracts(
            raiseMoney,
            msg.sender
        );
        deployedContracts.push(_deployedContract);
    }
}
