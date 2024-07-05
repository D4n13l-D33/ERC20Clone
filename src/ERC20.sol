// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

contract ERC20 {
    
    struct Token{
    string name;
    string symbol;
    uint8 decimals;
    uint256 totalSupply;
    mapping (address => uint) balances;
    mapping (address => mapping(address => uint)) allowances;
    }

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    function name() external view returns (string memory) {
        return Token.name;
    }

    function symbol() external view returns (string memory) {
        return Token.symbol;
    }

    function decimals() external view returns (uint8) {
        return Token.decimals;
    }

    function totalSupply() public view returns (uint256) {
        return Token.totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        balance = Token.balances[_owner];
    }

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(Token.balances[msg.sender] >= _value);
        Token.balances[msg.sender] -= _value;
        Token.balances[_to] += _value;
        success = true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        uint256 t_allowance = Token.allowances[_from][msg.sender];
        if (msg.sender == _from || Token.allowances[_from][msg.sender] >= _value) {
            Token.allowances[_from][msg.sender] = t_allowance - _value;
            uint256 frombalances = Token.balances[msg.sender];
       require(
            frombalances >= _value,
            "ERC20: Not enough tokens to transfer"
            );
            Token.balances[_from] = frombalances - _value;
            Token.balances[_to] += _value;
            emit Transfer(_from, _to, _value);
            emit Approval(_from, msg.sender, t_allowance - _value);

            success = true;
        } else {
            revert("ERC20: Not enough allowance to transfer");
        }
    }

    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        Token.allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        success = true;
    }

    function allowance(
        address _owner,
        address _spender
    ) public view returns (uint256 remaining_) {
        remaining_ = Token.allowances[_owner][_spender];
    }

    function mintTo(address _user, uint256 amount) external {
        Token.balances[_user] += amount;
        Token.totalSupply += uint96(amount);
        emit Transfer(address(0), _user, amount);
    }
}