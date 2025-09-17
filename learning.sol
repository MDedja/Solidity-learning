// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Learning {
    // types
    uint a = 1; //non negative integer
    int b = -1; //both positive and negative integer
    address addr = address(1); // holds addresses
    bool isTrue = true; // boolean value true or false
    string name = "Learning"; // holds string values
    bytes32 hash = keccak256(abi.encodePacked("Learning")); //keccak256 hash function returns 32 bytes value



    // functions
    // external is for it to be visible and callable outside from contract and pure is to say it does no writing or reading to block
    function add(int8 x, int8 y) external pure returns(int8){ // pure function
        return x+y;
    }

    // global variables
    address sender = msg.sender; // address of person calling contract/method ..
    uint256 blockNumber = block.number; // current block number
    uint256 timestamp = block.timestamp; // current block timestamp
    uint256 gasLeft = gasleft(); // gas left in the transaction


    // pure vs view functions
    // different from pure, view functions can read from blockchain

    function exampleView(uint256 x) external view returns(uint256){
        return x + a; // reading variable a ( defined on top of contract )
    }


    // Making state variable constants saves gas
    address public constant MY_ADDRESS = address(1); // by convention constants are written in uppercase - 351 gas
    address public MY_ADDRESS2 = address(2); // this is not a consant so it spends more gas to read it - 2530 gas


    // if else - same way of writing, ternary also available
    function ifElseExample(uint256 x) external pure returns(uint256){
        if(x<10){
            return 0;
        }else{
            return 1;
        }

        // code bellow does the same
        // return x < 10 ? 0 : 1;
    }


    // for and while loops are the same - Important!: keep number of loops and iteration small because each one spend more gas!
    function forLoopExample(uint256 x) external pure returns(uint256){
        uint256 sum = 0;
        for(uint256 i = 0; i < x; i++){
            sum += i;
        }
        return sum;
    }

    // for validation purposes there are 3 ways to go
    // require, revert, assert
    // the longer the message more gas it costs
    function requireExample(uint256 x) external pure{
        require(x>10, "x must be greater than 10"); // require is the most used one
    }

    function revertExample(uint256 x) external pure{ // revert is used when you want to do something more than just revert
        if(x<=10){
            revert("x must be greater than 10");
        }
    }

    function assertExample(uint256 x) external pure{
        assert(x>10); // assert is used for internal errors and checking invariants - to check something that is always true and if it fails probably a bug in the code
    }

    // also there is a custom errors - they save gas! 
      error Unauthorized(address sender, int i); //- custom error
      function customErrorExample(int i) external view {
        if(i < 10) revert Unauthorized(msg.sender, i); //- revert with custom error
    }



    // Modifiers - extract some logic to one place
    bool public isOwner;
    modifier ownerOnly {
        require(isOwner, "Not owner");
        _; // this tells modifier to continue with the function
    }
    function someFunctionOnlyOwnerCanCall() external ownerOnly {
        // some logic
    }

    modifier adultOnly(int age){
        require(age >= 18, "Not adult");
        _; // this tells modifier to continue with the function
    }
    function someFunctionOnlyAdultOwnerCanCall(int age) external ownerOnly adultOnly(age) {
        // some logic
    }

    // sandwitch modifier - execute modifier, execute function, execute next part of modifier
    modifier someModifer {
        // some logic
        _;
        // some logic after function execution
    }


    // consturctors - same thing only called once helps initialize values
    constructor() {
        isOwner = true;
    }

}