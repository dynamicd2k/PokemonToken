const PokemonToken = artifacts.require("./PokemonToken.sol");

module.exports = function(deployer) {
  deployer.deploy(PokemonToken);
};