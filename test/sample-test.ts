import { expect } from "chai";
import  { ethers } from "hardhat";
import { Contract, ContractFactory, Signer } from "ethers";

describe("Factory", function () {
    let NFTCreatorContract: ContractFactory;
    let nftCreator: Contract;
    let ERC721CollectionContract: ContractFactory;
    let owner: any;
    let addr1: any;
    let addr2: any;
    let addrs: any[];

    beforeEach(async function() {
        // Get additional addresses to play with.
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

        // Instantiate the NFTCreator contract.
        NFTCreatorContract = await ethers.getContractFactory("NFTCreator");

        // Deploy the NFTCreator factory as owner signer.
        nftCreator = await NFTCreatorContract.deploy();
        await nftCreator.deployed();

        // Instantiate the ERC721Collection contract.
        ERC721CollectionContract = await ethers.getContractFactory("ERC721Collection");

    });

    it("Create an empty collection", async function () {
        // Check that total token supply is zero.
        const createTx  = await nftCreator.connect(addr1).createERC721("collection1", "item");
        const txReceipt = await ethers.provider.getTransactionReceipt(createTx.hash);
        const cAddress  = txReceipt.logs[0].address;

        // Retreive the collection from its address.
        const collection = await ERC721CollectionContract.attach(cAddress);

        // Ensure the collection is empty.
        expect(await collection.totalSupply()).to.equal(0);
    });
});
