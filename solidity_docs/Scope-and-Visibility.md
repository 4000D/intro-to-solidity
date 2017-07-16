<!-- https://solidity.readthedocs.io/en/develop/contracts.html#visibility-and-getters -->

#### Visibility and Getters
Since Solidity knows two kinds of function calls (internal ones that do not create an actual EVM call (also called a “message call”) and external ones that do), there are four types of visibilities for functions and state variables.

Functions can be specified as being external, public, internal or private, where the default is public. For state variables, external is not possible and the default is internal.

- external:  
External functions are part of the contract interface, which means they can be called from other contracts and via transactions. An external function f cannot be called internally (i.e. f() does not work, but this.f() works). External functions are sometimes more efficient when they receive large arrays of data.

- public:   
Public functions are part of the contract interface and can be either called internally or via messages. For public state variables, an automatic getter function (see below) is generated.

- internal:  
Those functions and state variables can only be accessed internally (i.e. from within the current contract or contracts deriving from it), without using this.

- private:  
Private functions and state variables are only visible for the contract they are defined in and not in derived contracts.

```solidity
// This will not compile
pragma solidity ^0.4.0;

contract C {
    uint private data;

    function f(uint a) private returns(uint b) { return a + 1; }
    function setData(uint a) { data = a; }
    function getData() public returns(uint) { return data; }
    function compute(uint a, uint b) internal returns (uint) { return a+b; }
}

contract D {
    function readData() {
        C c = new C();
        uint local = c.f(7); // error: member "f" is not visible
        c.setData(3);
        local = c.getData();
        local = c.compute(3, 5); // error: member "compute" is not visible
    }
}

contract E is C {
    function g() {
        C c = new C();
        uint val = compute(3, 5);  // acces to internal member (from derivated to parent contract)
        uint val2 = f(2); // Maybe error
    }
}
```

type     | contract interface | externally callable | internally callable | without using `this` | inheritable
---------|--------------------|---------------------|---------------------|----------------------|------------
external | O                  | O                   |                     |                      |
public   | O                  | O                   | O                   |                      |
internal |                    |                     | O                   | O                    | O
private  |                    |                     | O                   | O                    | X
