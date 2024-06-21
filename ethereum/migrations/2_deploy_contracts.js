const TrafficControl = artifacts.require("TrafficControl");

module.exports = function(deployer) {
  deployer.deploy(TrafficControl);
};
