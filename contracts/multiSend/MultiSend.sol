//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
contract MultiSend {

    using SafeERC20 for IERC20;
    using Address for *;
    address constant private ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;


    /*
    * @param token_ => The address of toke that  want to send
    * @param recipient => The Array of address that send token
    * @param amount => The amount of token send to address (same amount to all addresses)
    */ 
    function sendTo(address token_, address payable[] memory recipient, uint256 amount) external payable returns(bool) {
        require(amount> 0 && recipient.length >0, "zero amount or empty array");

        //calculate total amount to send
        uint256 totalAmount = (recipient.length) * amount;

        if(token_ == ETH_ADDRESS) {
          require(totalAmount == msg.value, "Invalid amount to send");
          for(uint256 i=0; i< recipient.length; i++) {
            require(recipient[i] != address(0), "don't send to Zero address");
            recipient[i].sendValue(amount);
            
          }
          return true;
        } else {
            IERC20 token = IERC20(token_);
            uint256 balaceOfSender = token.balanceOf(msg.sender);
            require(balaceOfSender >= amount, "Invalid amount to send");
            token.safeTransfer(address(this), totalAmount);
            for(uint256 i=0; i< recipient.length; i++) {
                require(recipient[i] != address(0), "don't send to Zero address");
                token.safeTransfer(recipient[i], amount) ;
          }
          return true;
            
        }
        
        
        



    }


}