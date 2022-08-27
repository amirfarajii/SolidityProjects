//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EtherWallet is Ownable {
    mapping(address => uint256) internal depositor;
    event Deposit(address indexed sender, uint256 amount);
    event Withdraw(address indexed recipient, uint256 amount);
    using Address for *;

    function withdraw(address recipient, uint256 amount)
        external
        onlyOwner
        returns (bool)
    {
        require(amount <= address(this).balance, "not enogh eth in contract");
        payable(recipient).sendValue(amount);
        emit Withdraw(recipient, amount);
        return true;
    }

    receive() external payable {
        depositor[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
}
