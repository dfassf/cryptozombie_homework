pragma solidity ^0.4.19;

//2. 여기에 컨트랙트 생성
contract ZombieFactory {
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    // uint[2] fixedArray; 고정 배열 렝스 2
    // 타입 갯수 이름
    //uint[] dynamicArray; 타입 배열명

    Zombie[] public zombies;

    function createZombie(string _name, uint _dna) {
        zombies.push(Zombie(_name, _dna));
    }

}