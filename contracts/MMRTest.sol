    
// SPDX-License-Identifier: MIT
// Bridge between ethereum and verus

pragma solidity >=0.5.16 <0.7.1;
import "./BLAKE2B/BLAKE2b.sol";
pragma experimental ABIEncoderV2;
contract MMRTest {
    
    BLAKE2b blake;

    constructor() public{
        blake = new BLAKE2b();
    }
    function testParameters() public returns(uint64[8] memory){
        
        //bytes memory hashInProgress = abi.encodePacked(hashToCheck);
        //bytes memory test = "0x32";
        //uint64[8] memory testOutput = blake.blake2b("abc","",64);
        uint64[8] memory result = blake.blake2b("The quick brown fox jumped over the lazy dog.", "", 64);
        //return testOutput;
        return result;
    }
/*
    function testFinalHash() public{
    
        uint64[8] memory result = blake.blake2b("abc", "", 64);
        uint64[8] memory trueHash = [0xba80a53f981c4d0d,0x6a2797b69f12f6e9,
                                    0x4c212f14685ac4b7,0x4b12bb6fdbffa2d1,
                                    0x7d87c5392aab792d,0xc252d5de4533cc95,
                                    0x18d38aa8dbf1925a,0xb92386edd4009923];

        require(result[0] == trueHash[0],"hash did not match");

    }*/
}   