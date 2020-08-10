//var Blake2b = artifacts.require("./BLAKE2b/BLAKE2b.sol");
var MMRProof = artifacts.require("./MMRProof.sol")
var Blake2b = artifacts.require("./BLAKE2b/Blake2b.sol")
var MMRTest = artifacts.require("./MMRTest.sol")

module.exports = function(deployer) {
  deployer.deploy(MMRProof);
  deployer.deploy(MMRTest);
  deployer.deploy(Blake2b);
};
