const hre = require("hardhat");

async function main() {
  // Get two test accounts from Hardhat
  const [owner, nonOwner] = await hre.ethers.getSigners();

  console.log("Owner address:    ", owner.address);
  console.log("Non-owner address:", nonOwner.address);

  // Deploy the contract using the owner account
  const RestrictedAccessContract = await hre.ethers.getContractFactory("RestrictedAccessContract");
  const contract = await RestrictedAccessContract.deploy();
  await contract.waitForDeployment();

  console.log("\nContract deployed to:", contract.target);

  // 1. Check initial data (defaults to 0)
  let data = await contract.getSomeData();
  console.log("Initial someData value        ->", data.toString());

  // 2. Owner updates the data to 42
  console.log('\n[Owner] Calling setSomeData(42)...');
  let tx = await contract.connect(owner).setSomeData(42);
  await tx.wait();

  data = await contract.getSomeData();
  console.log("Updated someData value        ->", data.toString());

  // 3. Non-owner attempts to update data (should revert)
  console.log('\n[Non-Owner] Attempting to call setSomeData(999)...');
  try {
    const unauthorizedTx = await contract.connect(nonOwner).setSomeData(999);
    await unauthorizedTx.wait();
  } catch (error) {
    console.log("Access blocked as expected! Error message:");
    console.log("->", error.message.includes("Only the contract owner can call this function") 
      ? "Reverted with: Only the contract owner can call this function" 
      : error.message);
  }

  // 4. Verify someData was not changed by the non-owner
  data = await contract.getSomeData();
  console.log("\nFinal someData value (unchanged) ->", data.toString());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
