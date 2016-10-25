pragma solidity ^0.4.2;

  /*
  Token Standard (without any additional functionality) Source: https://github.com/ethereum/EIPs/issues/20
  */
    contract Token {

      address public token = this;

      event Transfer(address indexed _from, address indexed _to, uint256 _value);
      event Approval(address indexed _owner, address indexed _spender, uint256 _value);

        function transfer(address _to, uint256 _value) returns (bool success) {
            //Default assumes totalSupply can't be over max (2^256 - 1).
            //If your token leaves out totalSupply and can issue more tokens as time goes on, you need to check if it doesn't wrap.
            //Replace the if with this one instead.
            //if (balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
            if (balances[msg.sender] >= _value && _value > 0) {
                balances[msg.sender] -= _value;
                balances[_to] += _value;
                Transfer(msg.sender, _to, _value);
                return true;
            } else { return false; }
        }

        function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
            //same as above. Replace this line with the following if you want to protect against wrapping uints.
            //if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
            if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
                balances[_to] += _value;
                balances[_from] -= _value;
                allowed[_from][msg.sender] -= _value;
                //Transfer(_from, _to, _value);
                return true;
            } else { return false; }
        }

        function balanceOf(address _owner) constant returns (uint256 balance) {
            return balances[_owner];
        }

        function approve(address _spender, uint256 _value) returns (bool success) {
            allowed[msg.sender][_spender] = _value;
            Approval(msg.sender, _spender, _value);
            return true;
        }

        function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
          return allowed[_owner][_spender];
        }

        mapping (address => uint256) public balances;
        mapping (address => mapping (address => uint256)) public allowed;
        uint256 public totalSupply;



        /* Public variables of the token */

        /*
        NOTE:
        The following variables are OPTIONAL vanities. One does not have to include them.
        They allow one to customise the token contract & in no way influences the core functionality.
        Some wallets/interfaces might not even bother to look at this information.
        */
        string public name;                   //fancy name: eg Simon Bucks
        uint8 public decimals;                //How many decimals to show. ie. There could 1000 base units with 3 decimals. Meaning 0.980 SBX = 980 base units. It's like comparing 1 wei to 1 ether.
        string public symbol;                 //An identifier: eg SBX
        string public version = 'H0.1';       //human 0.1 standard. Just an arbitrary versioning scheme.

        function Token() {
            balances[msg.sender] = 100000;               // Give the creator all initial tokens
            totalSupply = 100000;                        // Update total supply
            name = "DSX_token";
        }

    }