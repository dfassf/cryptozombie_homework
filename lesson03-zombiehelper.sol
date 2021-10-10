pragma solidity ^0.4.19;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {
    modifier aboveLevel(uint256 _level, uint256 _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _; // 약간 next 느낌?
    }

    function changeName(uint256 _zombieId, string _newName)
        external
        aboveLevel(2, _zombieId)
    {
        // aboveLevel의 id 인자는 changeName에서 먼저 받아 들어온다
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }

    function changeDna(uint256 _zombieId, uint256 _newDna)
        external
        aboveLevel(20, _zombieId)
    {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }

    function getZombiesByOwner(address _owner) external view returns (uint[]) {
        //자꾸 리턴즈를 아래쪽에 쓰게 된다 더 익숙해져야 할 듯
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        //_owner라는 사람의 좀비 갯수를 zombiecount로 받고 이것이 곧 배열의 길이가 됨.
        return result;
  }
    }
}
