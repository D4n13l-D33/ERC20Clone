// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

contract Clone {
    address immutable owner; 
    address immutable impl;

    struct Token{
    string name;
    string symbol;
    uint8 decimals;
    uint256 totalSupply;
    mapping (address => uint) balances;
    mapping (address => mapping(address => uint)) allowances;
    }

    bool isInitialized;
    function initialize(string memory name, string memory symbol, uint8 decimal) public {
        require(!isInitialized, "you Can't initialized more than once");
        Token.name = name;
        Token.symbol = symbol;
        Token.decimals = decimal;
        isInitialized = true;

        
    }
    fallback () external {
        require (isInitialized, "Not Initialized yet");
        address _impl = impl;
        (bool ok, bytes memory data) = _impl.delegatecall(msg.data);
    }
}