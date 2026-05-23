// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RevenueDistributor is Ownable {
    IERC20 public assetToken;

    constructor(address _assetToken) Ownable(msg.sender) {
        assetToken = IERC20(_assetToken);
    }

    /**
     * @dev Distribute yield (USDC/DAI) based on ownership percentage.
     */
    function distribute(address[] calldata shareholders, uint256 totalReward) external onlyOwner {
        uint256 totalSupply = assetToken.totalSupply();
        
        for (uint256 i = 0; i < shareholders.length; i++) {
            uint256 balance = assetToken.balanceOf(shareholders[i]);
            uint256 share = (balance * totalReward) / totalSupply;
            
            // Interaction logic for actual token transfer would go here
            // e.g., usdc.transfer(shareholders[i], share);
        }
    }
}
