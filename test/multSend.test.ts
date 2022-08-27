import { expect } from "chai"
import { ethers } from "hardhat";
import { Contract, Signer, utils } from "ethers"


const Mock_ETH_Address = "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE";
;
async function deployContract(): Promise<Contract> {
    const MultiSend = await ethers.getContractFactory("MultiSend");
    let contract = await MultiSend.deploy();
    await contract.deployed();
    return contract;
}

async function connectContract(contract: Contract, account: Signer): Promise<Contract> {
    return contract.connect(account);
}

describe("MultiSend", async () => {
    //set variable need to use 
    let contract: Contract;
    let accounts: Signer[];
    accounts = await ethers.getSigners();

    //befor each describe excute this function 
    beforeEach(async () => {
        contract = await deployContract();

    })

    describe("has ETH address", async () => {
        it("ETH address", async () => {
            await connectContract(contract, accounts[0]);
            expect(await contract.getETHAddress()).to.eq(Mock_ETH_Address);
        })

    })

    describe("has owner", () => {
        it("owner ", async () => {
            await connectContract(contract, accounts[0]);
            expect(await contract.owner()).to.eq(await accounts[0].getAddress());
        })
    })

    describe("#sendTo", async () => {
        let Mock_receiver: Array<String> =[];
        let Mock_balace: Array<String> = [];
        let SIMPLE_AMOUNT = utils.formatEther("10000000");
         


        for (let i = 1; i < 6; ++i) {
            Mock_receiver.push(await accounts[i].getAddress());
            Mock_balace.push(utils.formatEther(await ethers.provider.getBalance( await accounts[i].getAddress()) ));
        }
        for (let i = 1; i < 6; ++i) {
            console.log(Mock_receiver[i], SIMPLE_AMOUNT[i])
        }
        describe("Send ETH", async () => {

        })


        describe("Send Token", async () => {

        })


    })
})