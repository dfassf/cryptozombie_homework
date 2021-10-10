pragma solidity ^0.4.19;

import "./lesson02-zombiefactory.sol";

contract KittyInterface {
    function getKitty(uint256 _id)
        external
        view
        returns (
            bool isGestating, //얘넨 뭔지 하나도 모르겠음
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );
}

contract ZombieFeeding is ZombieFactory {
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract = KittyInterface(ckAddress);

    // 잘 이해는 안되지만 이걸 바꾸면 뭔가 되겠지..
    function feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string _species
    ) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];

        _targetDna = _targetDna % dnaModulus; //타겟디엔에이를 16자로 제한한다?
        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        // 새로운 DNA는 먹잇감과 기존 좀비의 평균으로 내고 그 DNA를 바탕으로 좀비를 새로 생성

        if (keccak256(_species) == keccak256("kitty")) {
            newDna = newDna - (newDna % 100) + 99;
            // newDna
        }
        _createZombie("NoName", newDna);
    }

    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;
        (, , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}
