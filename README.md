# Audit Report - ETHPROOF Advanced Varun Ass3

We have 4 contracts here. The errors as showed by `slither` are showed at the top of each file in form of comments.

The files are as follow:

1. `StorageVictim0423.sol` - Original Contract File given in the questions.
2. `StorageVictim0423_new.sol` - Contract modified to remove all errors while maintaining version. Also corrected a logical error.
3. `StorageVictim0818.sol` - Contract rewritten in v0.8.18 without changing logic (Without error correction).
4. `StorageVictim0818_new.sol` - Removed all errors for v0.8.18.

## Problem Statement

With the help of Solidity security tips and tricks, design a minimal smart contract audit report for the following contract:

```
pragma solidity ^0.4.23;

contract StorageVictim {

   address owner;

   struct Storage {

       address user;
       uint amount;
   }

   mapping(address => Storage) storages;

   function StorageVictim() public {

       owner = msg.sender;
   }

   function store(uint _amount) public {

       // uninitialised pointer. str.user points to the storage address 0 which is "owner"

       Storage str;

       str.user = msg.sender;

       str.amount = _amount;

       storages[msg.sender] = str;

   }
   function getStore() public view returns (address, uint) {

       Storage str = storages[msg.sender];

       return (str.user, str.amount);
   }

   function getOwner() public view returns (address) {

       return owner;
   }
}
```

The above contract is written in an older version of Solidity(0.4.x), so you need to perform 3 steps in order to complete the above assessment:

Rewrite the above contract for 0.8x without changing the logic.. Create a small audit report with your findings on the contract. You can use the tools that you learnt in the lesson.. Suggest fixes for the errors that you find in your report..

You are recommended to use Testnet for testing purposes.

## Assessment Requirements

There are three requirements for the assessment:

1. Submit your project on GitHub.
2. Record a video of 5 min or less. Loom is a free online tool you could use. In the video, provide a code walk-through where you share your screen and explain the code. During the code walk-through, run your code and explain the resulting output.
3. Make sure your video includes a demo of your code (on CLI or GUI) to show the working of it in a test environment

Your project must provide the following to be successfully completed: Functionality

1. Produce a small security audit report for the above contract.
2. Suggest fixes for the found errors.

Go above and beyond the requirements by recording the functionality of the fixed contract and submit another updated report of security findings.

## Getting Started

### Installation & Testing

- Upload the given files to [Remix IDE](https://remix.ethereum.org/).
- Compile and run with the correct versions of specific files (v0.4.23,v0.8.18).
- Deploy and test all functions.

## Help

- The `StorageVictim0423.sol` and `StorageVictim0818.sol` files have the logical error that if you try to run the `getStore()` function then it returns 0x0 as the user address part.
- This is dangerous if the user has not already ran the `store()` function. Because the output of the user part is 0x0 can give problems if used as is.
- The `StorageVictim0423_new.sol` and `StorageVictim0818_new.sol` files have solved it by returning the sender name and corrected the logical error.

## Authors

- [Varun Anand Patkar](https://github.com/Varun-Patkar)

## License

This project is licensed under the MIT License - see the LICENSE file for details
