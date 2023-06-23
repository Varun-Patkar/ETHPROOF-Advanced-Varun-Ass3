//SPDX-License-Identifier: MIT

// INFO:Detectors:
// StorageVictim.store(uint256).str (StorageVictim0818.sol#21) is a local variable never initialized
// Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#uninitialized-local-variables
// INFO:Detectors:
// Parameter StorageVictim.store(uint256)._amount (StorageVictim0818.sol#18) is not in mixedCase
// Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions
// INFO:Detectors:
// StorageVictim.owner (StorageVictim0818.sol#5) should be immutable
// Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-immutable
// INFO:Slither:StorageVictim0818.sol analyzed (1 contracts with 85 detectors), 3 result(s) found

pragma solidity 0.8.18;

contract StorageVictim {
    address owner;

    struct Storage {
        address user;
        uint amount;
    }

    mapping(address => Storage) storages;

    constructor() {
        owner = msg.sender;
    }

    function store(uint _amount) public {
        // uninitialised pointer. str.user points to the storage address 0 which is "owner"

        Storage memory str;

        str.user = msg.sender;

        str.amount = _amount;

        storages[msg.sender] = str;
    }

    function getStore() public view returns (address, uint) {
        Storage memory str = storages[msg.sender];

        return (str.user, str.amount);
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
