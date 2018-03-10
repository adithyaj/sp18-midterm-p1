pragma solidity ^0.4.15;

import './interfaces/ERC20Interface.sol';

/**
 * @title Token
 * @dev Contract that implements ERC20 token standard
 * Is deployed by `Crowdsale.sol`, keeps track of balances, etc.
 */

contract Token is ERC20Interface {
    mapping (address => uint256) balSheet;
    mapping (address => mapping (address => uint256)) approvals;
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    uint256 totalSupply;
    address owner;

    function Token() {
        owner = msg.sender;
        totalSupply = 10000;
    }

    function setTotalSupply(uint256 _ts) {
        require(msg.sender == owner);
        totalSupply = _ts;
    }

    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balSheet[_owner];
    }


    function transfer(address _to, uint256 _value) returns (bool success) {
        if (_to == 0) {
            return false;
        }
        if (balSheet[msg.sender] < _value) {
            return false;
        }
        if (balSheet[_to] + _value < balSheet[_to]) {
            return false;
        }
        Transfer(msg.sender,_to,_value); 
        balSheet[msg.sender] -= _value;
        balSheet[_to] += _value;
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (_to == 0) {
            return false;
        }
        if (balSheet[_from] < _value) {
            return false;
        }
        if (balSheet[_to] + _value < balSheet[_to]) {
            return false;
        }
        Transfer(_from,_to,_value);
        balSheet[_from] -= _value;
        balSheet[_to] += _value;
        return true;
    }
    function approve(address _spender, uint256 _value) returns (bool success) {
        require(_value > 0);
        approvals[msg.sender][_spender] = _value;
        assert (approvals[msg.sender][_spender] >= _value);
        Approval(msg.sender,_spender,_value);
        return true;
    }
}
