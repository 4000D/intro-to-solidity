pragma solidity ^0.4.0; // specify solidity version

contract SimpleStorage {
    uint storedData; // internal storage
    // uint(== utin256) means deal with 256 bit data

    function set(uint x) {
        storedData = x; // allocate value to variable
    }

    // specify return type as 'constant returns (uint)'
    function get() constant returns (uint) {
        return storedData;
    }
}
