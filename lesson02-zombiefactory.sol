pragma solidity ^0.4.19;

import "./ownable.sol";

contract ZombieFactory is Ownable {
    event NewZombie(uint256 zombieId, string name, uint256 dna);

    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Zombie {
        string name;
        uint256 dna;
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;

    mapping(uint256 => address) public zombieToOwner;
    mapping(address => uint256) ownerZombieCount;

    // map 함수랑 같은 것 같은데 키가 address인건 생소하다.

    function _createZombie(string _name, uint256 _dna) internal {
        uint256 id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender; //좀비오너의 아이디를 sender로 지정
        ownerZombieCount[msg.sender]++; //좀비 수 추가
        NewZombie(id, _name, _dna);
        NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint256) {
        uint256 rand = uint256(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        //ownerZombieCount가 0이어야 한다
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
