const TupperCoin = artifacts.require("TupperCoin")

module.exports = function (deployer) {
    deployer.deploy(TupperCoin);
}