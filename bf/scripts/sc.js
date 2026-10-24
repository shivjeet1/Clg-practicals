const hre = require("hardhat");

async function main() {
  const MessageStorage = await hre.ethers.getContractFactory("MessageStorage");
  const contract = await MessageStorage.deploy();
  await contract.waitForDeployment();

  console.log("MessageStorage deployed to:", contract.target);

  // 1. Check initial message (should be empty string)
  let currentMsg = await contract.getMessage();
  console.log('Initial message        -> "' + currentMsg + '"');

  // 2. Set a new message and wait for the transaction to be mined
  console.log('\nSetting message to: "Hello from Hardhat!"...');
  let tx = await contract.setMessage("Hello from Hardhat!");
  await tx.wait();

  // 3. Read the updated message
  currentMsg = await contract.getMessage();
  console.log('Updated message        -> "' + currentMsg + '"');

  // 4. Update the message again
  console.log('\nSetting message to: "Blockchain Practical Completed!"...');
  tx = await contract.setMessage("Blockchain Practical Completed!");
  await tx.wait();

  // 5. Read final message
  currentMsg = await contract.getMessage();
  console.log('Final message          -> "' + currentMsg + '"');
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
