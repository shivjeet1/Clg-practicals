const hre = require("hardhat");

async function main() {
  const CryptographicFunctions = await hre.ethers.getContractFactory("CryptographicFunctions");
  const contract = await CryptographicFunctions.deploy();
  await contract.waitForDeployment();

  console.log("CryptographicFunctions deployed to:", contract.target);

  const sampleData = "Hello Blockchain";
  // Convert a key string into hex bytes for the HMAC function
  const secretKey = hre.ethers.toUtf8Bytes("secretKey123");

  console.log(`\nInput Data: "${sampleData}"\n`);

  // 1. SHA256 Hash
  const sha256Result = await contract.sha256Hash(sampleData);
  console.log("sha256Hash        ->", sha256Result);

  // 2. Keccak256 (SHA3) Hash
  const keccakResult = await contract.keccak256Hash(sampleData);
  console.log("keccak256Hash     ->", keccakResult);

  // 3. RIPEMD160 Hash (returns 20 bytes)
  const ripemdResult = await contract.ripemd160Hash(sampleData);
  console.log("ripemd160Hash     ->", ripemdResult);

  // 4. HMAC Calculation
  const hmacResult = await contract.calculateHMAC(secretKey, sampleData);
  console.log("calculateHMAC     ->", hmacResult);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
