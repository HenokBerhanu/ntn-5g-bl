module.exports = {
  networks: {
    development: {
      host: "172.23.0.2",
      port: 8545,
      network_id: "*", // Match any network id
    },
  },
  compilers: {
    solc: {
      version: "0.8.0", // Specify the Solidity compiler version
    },
  },
};
