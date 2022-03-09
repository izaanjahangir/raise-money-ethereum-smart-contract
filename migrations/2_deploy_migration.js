const RaiseMoneyFactory = artifacts.require("RaiseMoneyFactory");

module.exports = function (deployer) {
  deployer.deploy(RaiseMoneyFactory);
};
