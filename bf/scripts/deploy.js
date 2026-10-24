const hre = require("hardhat");

async function main() {
  const [deployer, recipientSigner] = await hre.ethers.getSigners();

  // You can replace this with an address from Ganache or use the second local test account:
  const recipient = recipientSigner ? recipientSigner.address : "0x5F65AF4914DcD4ece16177394D810588413a3AC2";

  const TransferContract = await hre.ethers.getContractFactory("TransferContract");
  const contract = await TransferContract.deploy(recipient);

  // Replaces await contract.deployed() in ethers v6
  await contract.waitForDeployment();

  // Replaces contract.address in ethers v6
  console.log("Contract deployed to address:", contract.target);

  // Perform the transfer of 12 ETH
  // Replaces ethers.utils.parseEther("12") in ethers v6
  const amount = hre.ethers.parseEther("12");
  const tx = await contract.transfer({ value: amount });
  await tx.wait();

  // Check the recipient's balance
  const recipientBalance = await hre.ethers.provider.getBalance(recipient);
  console.log("Recipient balance:", hre.ethers.formatEther(recipientBalance), "ETH");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
