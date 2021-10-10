// pragma solidity ^0.4.19; // 이유는 모르겠으나 주석달지 않으면 안됨..

contract ZombieFactory {
    // 제일 큰 단위 같은데 한 파일에 여러개를 쓸 수 있는지는 모르겠음.
    // -> contract를 추가하니 빨간줄이 그어지는걸 보면 안되는 것 같음
    // 여기서 시작

    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits; // 세미콜론 붙이는게 씨쁠쁠같네
    //왜 이렇게 됐는지 모르겠음

    struct Zombie {
        // contract가 js 파일이라면 이건 그 안에서 변수를 설정한 느낌?
        string name;
        uint256 dna;
    }
}
