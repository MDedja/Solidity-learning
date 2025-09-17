// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Counter{
    int public counter = 0;

    function increment() external returns(int){
        counter += 1;
        return counter;   
    }

    function decrement() external returns(int){
        counter -= 1;
        return counter;
    }

    function counterValue() external view returns(int) {
        return counter;
    }


}