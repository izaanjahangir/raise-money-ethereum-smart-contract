// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract RaiseMoney {
    address payable public manager;
    uint256 public minimumContribution = 1000000000000000;
    string public description;
    uint256 public amountNeeded = 0;
    uint256 public amountRaised;
    mapping(address => bool) public contributors;
    int256 public contributorsCount = 0;
    struct ContributorDetails {
        address contributor;
        uint256 contributedAmount;
    }
    ContributorDetails[] public contributorDetails;

    constructor(
        address payable _manager,
        string memory _description,
        uint256 _amountNeeded
    ) {
        manager = _manager;
        description = _description;
        amountNeeded = _amountNeeded;
    }

    function contribute() public payable isValidContribution {
        require(
            !contributors[msg.sender],
            "You already contributed to this compaign"
        );

        amountRaised += msg.value;
        contributors[msg.sender] = true;
        contributorsCount++;

        ContributorDetails memory _contributorDetails = ContributorDetails(
            msg.sender,
            msg.value
        );

        contributorDetails.push(_contributorDetails);
    }

    function getDetails()
        public
        view
        returns (
            address,
            string memory,
            uint256,
            uint256,
            int256,
            ContributorDetails[] memory
        )
    {
        return (
            manager,
            description,
            amountNeeded,
            amountRaised,
            contributorsCount,
            contributorDetails
        );
    }

    function withdraw() public onlyManager {
        manager.transfer(address(this).balance);
    }

    modifier onlyManager() {
        require(msg.sender == manager, "You should be a manager to continue");
        _;
    }

    modifier isValidContribution() {
        require(
            msg.value >= minimumContribution,
            "Please add amount greater than minimum amount"
        );
        _;
    }
}
