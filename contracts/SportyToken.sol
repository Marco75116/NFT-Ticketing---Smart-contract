// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;


import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SportyToken is Context, ERC20 {
    constructor() public ERC20("SportyToken ", "SPTK") {
        _mint(_msgSender(), 10000 * (10**uint256(decimals())));
    }
}