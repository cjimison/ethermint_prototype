pragma solidity >=0.4.22 <0.7.0;

// This is my simple implementation of a TBC.
contract TokenBondingCurve {
    address public owner;
    mapping(address => uint256) public balances;

    uint256 constant numSegments = 16;
    uint256 constant maxTokenMint = 1_000_000_000;

    uint256 coins;
    uint256 tokens;

    uint16 segIdx;
    uint16 segCount;
    uint256[] segX;
    uint256[] segRun;
    uint256[] segRise;

    constructor() public {
        owner = msg.sender;
        coins = 0;
        tokens = 0;
        segCount = 0;
        segIdx = 0;

        segX = new uint256[](numSegments);
        segRun = new uint256[](numSegments);
        segRise = new uint256[](numSegments);
    }

    function pushSegment(uint256 x, uint256 run, uint256 rise) public {
        require(msg.sender == owner, "Access to API denied");
        require(run > 0, "You can not have a segment with a zero run");
        require(rise > 0, "You can not have a segment with a zero rise");
        uint256 theX = x;
        if (x < coins) {
            theX = coins;
        }
        segX[segCount] = theX;
        segRun[segCount] = run;
        segRise[segCount] = rise;
        segCount++;
    }

    function mint(uint256 numTokens) public returns (uint256 coinCount) {
        require(segCount > 0, "Invalid State, no line segments");
        require(numTokens > maxTokenMint, "Token Mint request is too large");

        uint256 y1 = coins;
        uint256 y2 = ((segRun[segIdx] * (numTokens - tokens)) /
            segRise[segIdx]) +
            coins;

        uint256 area = coins * numTokens + ((y2 - y1) * numTokens) / 2;

        coins += area;
        tokens += numTokens;

        return area;
    }
}
