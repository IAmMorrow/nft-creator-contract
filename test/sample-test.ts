import { expect } from "chai";
import  { ethers } from "hardhat";
import { BigNumber } from "ethers";

describe("TheFrontMan", function () {
  it("Should create a game", async function () {
    const StakeGameToken = await ethers.getContractFactory("StakeGameToken");
    const stakeGameToken = await StakeGameToken.deploy(BigNumber.from("1000000000000000000000000")); // 10 * 10**6 * 10**18
    await stakeGameToken.deployed();
    console.log(stakeGameToken.address)

    const TheFrontMan = await ethers.getContractFactory("TheFrontMan");
    const theFrontMan = await TheFrontMan.deploy();
    await theFrontMan.deployed();

    const newGameTX = await theFrontMan.newGame([stakeGameToken.address], [0], Math.floor(Date.now() /1000), 8, 60 * 10, 100);
    await newGameTX.wait();

    const gameCount = await theFrontMan.gameCount();
    expect(gameCount).to.equal(1);

    const gameId = await theFrontMan.gameById(0);

    console.log(gameId)

    const approveTX = await stakeGameToken.approve(theFrontMan.address, "100000000");
    await approveTX.wait();

    const stakeTX = await theFrontMan.stake(0);
    await stakeTX.wait();
  });
});
