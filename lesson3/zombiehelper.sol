pragma solidity ^0.4.19;

import "../lesson2/zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

    uint levelUpFee = 0.001ether;

    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }

    function withdraw() external onlyOwner {
        owner.transfer(this.balance);
    }

    function levelUp(uint _zombieId) external payable {
        require(msg.value == levelUpFee);
        zombies[_zombieId].level++;
    }

    function setLevelUpFee(uint _fee) external onlyOwner {
        levelUpFee = _fee;
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
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        uint counter = 0;

        for(uint i = 0; i < zombies.length; i ++ ) {
            if(zombieToOwner[i] == _owner) {
                result[counter] = i;
                counter ++;
            }
        }
    }
}
