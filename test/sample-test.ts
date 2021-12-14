import { expect } from "chai";
import  { ethers } from "hardhat";

describe("Factory", function () {
    it("Create an empty collection", async function () {
        const [owner, addr1] = await ethers.getSigners();

        // Deploy the NFTCreator factory as owner signer.
        const NFTCreatorContract = await ethers.getContractFactory("NFTCreator");
        const nftCreator         = await NFTCreatorContract.deploy();
        await nftCreator.deployed();

        // Create a collection as another signer (i.e. addr1).
        const ERC721CollectionContract = await ethers.getContractFactory("ERC721Collection");

        // Check that total token supply is zero.
        const createTx  = await nftCreator.connect(addr1).createERC721("collection1", "item");
        const txReceipt = await ethers.provider.getTransactionReceipt(createTx.hash);
        const cAddress  = txReceipt.logs[0].address;

        const collection = await ERC721CollectionContract.attach(cAddress);
        expect(await collection.totalSupply()).to.equal(0);
  });
});
