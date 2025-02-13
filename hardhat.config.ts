import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: {
    compilers:[{
      version: "0.8.22",
      settings: {
        optimizer: {
          enabled: true
        }
      }
    },{
      version: "0.8.19",
      settings: {
        optimizer: {
          enabled: true
        }
      }
    },{
      version: "0.5.17",
      settings: {
        optimizer: {
          enabled: true
        }
      }
    }]
  }
};

export default config;
