import hre from "hardhat";

const deployContract = async () => {
    const NFTCreator = await hre.ethers.getContractFactory("NFTCreator");
    console.log("deploying contract ...")
    const nftCreatorContract = await NFTCreator.deploy();
    console.log("waiting for confirmations ...")
    await nftCreatorContract.deployTransaction.wait(10);
    console.log(`contract deployed to ${nftCreatorContract.address}`)

    try {
      await hre.run("verify:verify", {
        address: nftCreatorContract.address,
        constructorArguments: [],
      });
      console.log("Verified successfully !")
    } catch (err) {
      console.error(err);
    }
    return nftCreatorContract;
  }

async function main() {
    const [account] = await hre.ethers.getSigners();
    const balance = await account.getBalance();
  
    console.log(`Deployer address is: ${account.address}`);
    console.log(`Deployer balance is: ${balance}`);

    if (!balance.isZero()) {
        await deployContract();
    }
}
  
  // We recommend this pattern to be able to use async/await everywhere
  // and properly handle errors.
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  