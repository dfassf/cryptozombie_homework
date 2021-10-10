/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address public owner;
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    //퍼블릭으로 소유자 선언하고 소유권 이전에 대한 이벤트 선언

    /**
     * @dev The Ownable constructor sets the original `owner` of the contract to the sender
     * account.
     */
    function Ownable() public {
        owner = msg.sender;
    } // 오너블 컨스트럭터는 컨트랙트의 원 소유자를 센더의 계정으로 지정한다

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        //모디파이어는 뭔지 모르겠지만 센더가 소유자여야 함.. _;는 뭐지..
        require(msg.sender == owner);
        _;
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    } // 모디파이어는 뭔가 특정해주는 느낌인 것 같은데, public함수이지만 onlyOwner만 접근 가능한 함수?
    //뉴오너가 0이 아닌게 무슨 상관인지는 잘 모르곘음.
}
