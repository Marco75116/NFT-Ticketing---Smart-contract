require("@nomicfoundation/hardhat-toolbox");
// require("dotenv").config();

const { ALCHEMY_KEY, ACCOUNT_PRIVATE_KEY } = process.env;

module.exports = {
  solidity: "0.8.17",
  defaultNetwork: "mumbai",
  networks: {
    mumbai: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/JqONBeMyo5H9bsM5NLQwV8TY-owhj2aZ",
      accounts: [
        `0xd5a710ddb407b782449d120b833a058be6c710b06a64d79d67b24513aaf67c6f`,
      ],
    },
    goerli: {
      url: `https://eth-goerli.alchemyapi.io/v2/_i01IL9gaVOEi674oqczrHH7430eJ0zR`,
      accounts: [
        `0xd5a710ddb407b782449d120b833a058be6c710b06a64d79d67b24513aaf67c6f`,
      ],
    },
  },
};
