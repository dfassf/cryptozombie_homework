// pragma solidity ^0.4.19; // 이유는 모르겠으나 주석달지 않으면 안됨..

contract ZombieFactory {
    // 제일 큰 단위 같은데 한 파일에 여러개를 쓸 수 있는지는 모르겠음.
    // -> contract를 추가하니 빨간줄이 그어지는걸 보면 안되는 것 같음
    // 여기서 시작
    event NewZombie(uint256 zombieId, string name, uint256 dna);
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits; // 세미콜론 붙이는게 씨쁠쁠같네
    //왜 이렇게 됐는지 모르겠음

    struct Zombie {
        // contract가 js 파일이라면 이건 그 안에서 변수를 설정한 느낌?
        string name;
        uint256 dna;
    }

    Zombie[] public Zombies;

    function _createZombie(string _name, uint256 _dna) private {
        //인자 선언할 때 전부 타입을 지정해줘야 함...귀찮네
        uint256 id = Zombies.push(Zombie(_name, _dna)) - 1;
        // 왜 빨간줄이 그어지는건지 모르겠음. push 이건 자스랑 비슷하네
        NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private returns (uint256) {
        uint256 rand = uint256(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
