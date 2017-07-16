pragma solidity ^0.4.0;

contract Coin {
    // datatype address for account address.
    //
    // The keyword "public" makes those variables
    // readable from outside.
    address public minter;
    // function minter() returns (address) { return minter; }
    // is implied in public keyword

    // mapping is kind of associative array, ...
    mapping (address => uint) public balances;

    // Events allow light clients to react on
    // changes efficiently.
    // Client can listen to Event occurance
    event Sent(address from, address to, uint amount);

    // This is the constructor whose code is
    // run only when the contract is created.
    function Coin() {
        minter = msg.sender;
    }

    function mint(address receiver, uint amount) {
        if (msg.sender != minter) return;
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) {
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        Sent(msg.sender, receiver, amount);
    }
}
