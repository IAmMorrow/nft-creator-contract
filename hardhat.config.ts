import "@nomiclabs/hardhat-waffle";
import "@nomiclabs/hardhat-etherscan";

import { task } from "hardhat/config";

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    mumbai: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: {
        mnemonic: "pizza delay learn inmate nature amateur regular giant nothing include east pear myself daring tooth keep vivid corn flower begin ceiling glimpse dose pattern"
      }
    }
  },
  solidity: {
    version: "0.8.9",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: "F5CKXAUUUA4P7A6ISD5YJFGQGKJZIM1NVQ" //"F5CKXAUUUA4P7A6ISD5YJFGQGKJZIM1NVQ"
  }
};
