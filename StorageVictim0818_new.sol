//SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// INFO:Slither:StorageVictim0818_new.sol analyzed (1 contracts with 85 detectors), 0 result(s) found

contract StorageVictim {
    address immutable owner; //make owner immutable

    struct Storage {
        address user;
        uint amount;
    }

    mapping(address => Storage) storages;

    constructor() {
        owner = msg.sender;
    }

    function store(uint amount) public {
        //_amount not mixed case

        // uninitialised pointer. str.user points to the storage address 0 which is "owner"
        Storage memory str = Storage(msg.sender, 0); //Initilise local variable

        str.user = msg.sender;

        str.amount = amount;

        storages[msg.sender] = str;
    }

    function getStore() public view returns (address, uint) {
        Storage memory str = storages[msg.sender];
        if (str.user == address(0)) {
            return (msg.sender, 0);
        }
        return (str.user, str.amount);
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
