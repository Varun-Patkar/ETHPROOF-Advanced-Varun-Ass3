pragma solidity ^0.4.23;

//0.4.23 not recommended for deployment

// INFO:Detectors:
// Pragma version^0.4.23 (StorageVictim0423_new.sol#1) allows old versions
// solc-0.4.23 is not recommended for deployment
// Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
// INFO:Slither:StorageVictim0423_new.sol analyzed (1 contracts with 85 detectors), 2 result(s) found

contract StorageVictim {
    address owner;

    struct Storage {
        address user;
        uint amount;
    }

    mapping(address => Storage) storages;

    constructor() public {
        //use constructor() instead of function StorageVictim()
        owner = msg.sender;
    }

    function store(uint amount) public {
        // uninitialised pointer. str.user points to the storage address 0 which is "owner"

        Storage memory str = Storage(msg.sender, 0); //define memory or storage for struct variable
        //also initilise local variable

        str.user = msg.sender;

        str.amount = amount;

        storages[msg.sender] = str;
    }

    function getStore() public view returns (address, uint) {
        Storage memory str = storages[msg.sender]; //define memory or storage for struct variable
        if (str.user == address(0)) {
            return (msg.sender, 0);
        }
        return (str.user, str.amount);
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
