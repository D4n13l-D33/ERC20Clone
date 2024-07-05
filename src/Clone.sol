// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

contract Clone {
    address immutable impl;
    
    struct Token{
    string name;
    string symbol;
    uint8 decimals;
    uint256 totalSupply;
    mapping (address => uint) balances;
    mapping (address => mapping(address => uint)) allowances;
    }

    fallback () external {

    }
}