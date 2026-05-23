// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title AssetToken
 * @dev Represents fractional ownership of a Real-World Asset (e.g., a Building).
 */
contract AssetToken is ERC20, Ownable {
    mapping(address => bool) public isWhitelisted;
    uint256 public totalAssetValue;

    event AssetValueUpdated(uint256 newValue);

    constructor(
        string memory name, 
        string memory symbol, 
        uint256 _initialSupply,
        uint256 _totalValue
    ) ERC20(name, symbol) Ownable(msg.sender) {
        _mint(msg.sender, _initialSupply * 10**decimals());
        totalAssetValue = _totalValue;
    }

    /**
     * @dev Restricts transfers to whitelisted (KYC-compliant) addresses.
     */
    function _update(address from, address to, uint256 value) internal virtual override {
        if (from != address(0) && to != address(0)) {
            require(isWhitelisted[to], "Recipient not whitelisted");
        }
        super._update(from, to, value);
    }

    function addToWhitelist(address account) external onlyOwner {
        isWhitelisted[account] = true;
    }

    function updateAssetValue(uint256 _newValue) external onlyOwner {
        totalAssetValue = _newValue;
        emit AssetValueUpdated(_newValue);
    }
}
