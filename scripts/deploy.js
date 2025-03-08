const hre = require("hardhat");

async function main() {
  const DisasterReliefDAO = await hre.ethers.getContractFactory("DisasterReliefDAO");
  const dao = await DisasterReliefDAO.deploy();

  await dao.waitForDeployment();

  console.log("DAO deployed to:", dao.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});