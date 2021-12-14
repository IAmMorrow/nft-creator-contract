import { expect } from "chai";
import  { ethers } from "hardhat";

describe("Factory", function () {
    it("Create an empty collection", async function () {
        const [owner, addr1] = await ethers.getSigners();

        // Deploy the NFTCreator factory as owner signer.
        const Factory = await ethers.getContractFactory("NFTCreator");
        const factory = await Factory.deploy();
        await factory.deployed();

        // Create a collection as another signer (i.e. addr1).
        const Collection   = await ethers.getContractFactory("ERC721Collection");
        const createResult = await factory.connect(addr1).createERC721("collection1", "item");

        // Get the newly created collection from address.
        const colAddress1 = createResult.to;
        const collection1 = await Collection.attach(colAddress1);

        // Ensure that the collection is empty after creation.
        expect(await collection1.connect(addr1).totalSupply()).to.equal(0);
  });
});
