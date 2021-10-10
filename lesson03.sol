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
    KittyInterface kittyContract;

    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }

    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(now + cooldownTime);
    } // 쿨다운이 되려면 하루가 지나야 하는 것 같음?

    function _isReady(Zombie storage _zombie) internal view returns (bool) {
        return (_zombie.readyTime <= now);
    } // 쿨다운 되면 먹이를 먹을 준비가 됐는지 알려주는..

    // js 콘솔로그에 저거 찍으면 true/false 나오는 것처럼 저거 자체를 리턴할 수도 있네

    // 잘 이해는 안되지만 이걸 바꾸면 뭔가 되겠지..
    function feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string _species
    ) internal {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        require(_isReady(myZombie) == true); // 이거 틀리다고 하는데 그냥 써도 되지 않나..
        _targetDna = _targetDna % dnaModulus; //타겟디엔에이를 16자로 제한한다?
        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        // 새로운 DNA는 먹잇감과 기존 좀비의 평균으로 내고 그 DNA를 바탕으로 좀비를 새로 생성

        if (keccak256(_species) == keccak256("kitty")) {
            newDna = newDna - (newDna % 100) + 99;
            // newDna
        }
        _createZombie("NoName", newDna);
        _triggerCooldown(myZombie);
    }

    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;
        (, , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}
