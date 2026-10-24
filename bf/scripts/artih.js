const hre = require("hardhat");

async function main() {
  const factory = await hre.ethers.getContractFactory("ArithmeticOperations");
  const contract = await factory.deploy();
  await contract.waitForDeployment();

  console.log("add(10, 20):", (await contract.add(10, 20)).toString());
  console.log("divide(12, 2):", (await contract.divide(12, 2)).toString());
  console.log("multiply(19, 7):", (await contract.multiply(19, 7)).toString());
  console.log("subtract(23, 6):", (await contract.subtract(23, 6)).toString());
}

main().catch((err) => {
  console.error(err);
  process.exitCode = 1;
});
