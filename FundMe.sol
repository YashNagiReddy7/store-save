// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

import "@chainlink/contracts/src/v=VO.6/interfaces/AggregatorV3Interface.sol";


contract FundMe {

    mapping(address => uint256) public addressToAmountFunded;
    function fund() public payable {
        // $50
        addressToAmountFunded[msg.sender] += msg.value;
        // what the ETH -> USD conversion rate 
    }

    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x2431452A0010a43878bF198e170F6319Af6d27F4);
        return priceFeed.version();
    }

    function getPrice() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x2431452A0010a43878bF198e170F6319Af6d27F4);
        (int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer * 1000000000);


    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount);
        return ethAmountInUsd;
    }
}
