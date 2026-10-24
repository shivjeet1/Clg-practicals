const hre = require("hardhat");

async function main() {
  const LoopingStatements = await hre.ethers.getContractFactory("LoopingStatements");
  const contract = await LoopingStatements.deploy();
  await contract.waitForDeployment();

  console.log("LoopingStatements deployed to:", contract.target);

  // 1. Test forLoop with n = 5 (1 + 2 + 3 + 4 + 5 = 15)
  let tx = await contract.forLoop(5);
  await tx.wait();
  let currentSum = await contract.sum();
  console.log("forLoop(5) sum       ->", currentSum.toString());

  // 2. Test whileLoop with n = 10 (Sum from 1 to 10 = 55)
  tx = await contract.whileLoop(10);
  await tx.wait();
  currentSum = await contract.sum();
  console.log("whileLoop(10) sum     ->", currentSum.toString());

  // 3. Test doWhileLoop with n = 4 (1 + 2 + 3 + 4 = 10)
  tx = await contract.doWhileLoop(4);
  await tx.wait();
  currentSum = await contract.sum();
  console.log("doWhileLoop(4) sum    ->", currentSum.toString());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
