// SPDX-License-Identifier: MIT
// Bridge between ethereum and verus

pragma solidity >=0.5.16 <0.7.1;
import "./BLAKE2B/BLAKE2b.sol";
pragma experimental ABIEncoderV2;

contract MMRProof{

    uint256 mmrRoot;
    BLAKE2b blake2b;
    bytes verusKey = "VerusDefaultHash";
    

    constructor() public{
        blake2b = new BLAKE2b();
    }

    function safeCheck(bytes32 _hashToCheck,uint _hashIndex,bytes32[] memory _branch) public returns(bytes memory){
        
        require(_hashIndex >= 0,"Index cannot be less than 0");
        require(_branch.length > 0,"Branch must be longer than 0");
        uint branchLength = _branch.length;
        bytes memory hashInProgress;
        uint64[8] memory blakeResult;
        bytes memory joined;

        hashInProgress = abi.encodePacked(_hashToCheck);

       for(uint i = 0;i < branchLength; i++){
            if(_hashIndex & 1 > 0){
                require(_branch[i] != _hashToCheck,"Value can be equal to node but never on the right");
                //join the two arrays and pass to blake2b
                joined = abi.encodePacked(_branch[i],hashInProgress);
                
            } else {
                joined = abi.encodePacked(hashInProgress,_branch[i]);
            }
            blakeResult = blake2b.blake2b(joined,verusKey,64);
            hashInProgress = abi.encodePacked(blakeResult[0],blakeResult[1],blakeResult[2],blakeResult[3],
                blakeResult[4],blakeResult[5],blakeResult[6],blakeResult[7]);
            _hashIndex >>= 1;
        }

        return hashInProgress;

    }

    function testMMR(string memory testString) public returns(bytes memory){
        uint64[8] memory blakeResult;
        bytes memory testInput = bytes(testString);
        verusKey = "";
        blakeResult = blake2b.blake2b(testInput,verusKey,64);
        bytes memory hashInProgress = abi.encodePacked(blakeResult[0],blakeResult[1],blakeResult[2],blakeResult[3],
                blakeResult[4],blakeResult[5],blakeResult[6],blakeResult[7]);
        return hashInProgress;
    }

}