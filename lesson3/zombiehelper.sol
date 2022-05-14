pragma solidity ^0.4.19;

import "../lesson2/zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }

    function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieid].name = _newName;
    }

    function changeDna(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }

    function getZombiesByOwner(address _owner) external view returns(uint[]){
   
    }
}
