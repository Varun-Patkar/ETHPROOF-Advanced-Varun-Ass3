pragma solidity ^0.4.23;

// Compilation warnings/errors on StorageVictim0423.sol:
// StorageVictim0423.sol:13:5: Warning: Defining constructors as functions with the same name as the contract is deprecated. Use "constructor(...) { ... }" instead.
//     function StorageVictim() public {
//     ^ (Relevant source part starts here and spans across multiple lines).
// StorageVictim0423.sol:20:9: Warning: Variable is declared as a storage pointer. Use an explicit "storage" keyword to silence this warning.
//         Storage str;
//         ^---------^
// StorageVictim0423.sol:30:9: Warning: Variable is declared as a storage pointer. Use an explicit "storage" keyword to silence this warning.
//         Storage str = storages[msg.sender];
//         ^---------^
// StorageVictim0423.sol:20:9: Warning: Uninitialized storage pointer. Did you mean '<type> memory str'?
//         Storage str;
//         ^---------^

// INFO:Detectors:
// StorageVictim.store(uint256).str (StorageVictim0423.sol#20) is a storage variable never initialized
// Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#uninitialized-storage-variables
// INFO:Detectors:
// Pragma version^0.4.23 (StorageVictim0423.sol#1) allows old versions
// solc-0.4.23 is not recommended for deployment
// Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
// INFO:Detectors:
// Parameter StorageVictim.store(uint256)._amount (StorageVictim0423.sol#17) is not in mixedCase
// Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions
// INFO:Slither:StorageVictim0423.sol analyzed (1 contracts with 85 detectors), 4 result(s) found

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
