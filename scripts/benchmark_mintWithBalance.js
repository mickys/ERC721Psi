// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  const accounts = await hre.ethers.getSigners();
  const deployer = accounts[0];
  const user1 = accounts[1];
  const user2 = accounts[2];
  const user3 = accounts[3];

  let ERC721Psi, AddressData, ERC721A, ERC721Enumerable;

  ERC721Psi = await hre.ethers.getContractFactory("ERC721PsiMock");
  ERC721Psi = await ERC721Psi.deploy("ERC721Psi", "ERC721Psi");
  ERC721Psi = await ERC721Psi.deployed();

  AddressData = await hre.ethers.getContractFactory("ERC721PsiAddressDataMock");
  AddressData = await AddressData.deploy("ERC721PsiAddressData", "ERC721PsiAddressData");
  AddressData = await AddressData.deployed();

  ERC721A = await hre.ethers.getContractFactory("ERC721AMock");
  ERC721A = await ERC721A.deploy("ERC721A", "ERC721A");
  ERC721A = await ERC721A.deployed();

  ERC721Enumerable = await hre.ethers.getContractFactory("ERC721EnumerableMock");
  ERC721Enumerable = await ERC721Enumerable.deploy("ERC721Enumerable", "ERC721Enumerable");
  ERC721Enumerable = await ERC721Enumerable.deployed();

  // Mint at least one token before to initialize most of the parameters, 
  // so the result fits the real world scenerio better
  await ERC721Enumerable['safeMintBatch(address,uint256)'](user1.address, 1);
  await AddressData['safeMint(address,uint256)'](user1.address, 1);
  await ERC721Psi['safeMint(address,uint256)'](user1.address, 1);
  await ERC721A['safeMint(address,uint256)'](user1.address, 1);

  const user1TokenId = 0;
  await ERC721Enumerable['benchmarkContractMethods(uint256,address)'](user1TokenId, user1.address);  
  await AddressData['benchmarkContractMethods(uint256,address)'](user1TokenId, user1.address);  
  await ERC721Psi['benchmarkContractMethods(uint256,address)'](user1TokenId, user1.address);  
  await ERC721A['benchmarkContractMethods(uint256,address)'](user1TokenId, user1.address);  


  console.log("mint 100");

  const perLoop = 100;
  // for(let i = 1; i <= 10; i++){
    await ERC721Psi['safeMint(address,uint256)'](user1.address, 1 * perLoop);
    await AddressData['safeMint(address,uint256)'](user1.address, 1 * perLoop);
    await ERC721A['safeMint(address,uint256)'](user1.address, 1 * perLoop);
    await ERC721Enumerable['safeMintBatch(address,uint256)'](user1.address, 1 * perLoop);
    console.log("Minted", perLoop);
  // }

  await ERC721Enumerable['safeMintBatch(address,uint256)'](user2.address, 1);
  await AddressData['safeMint(address,uint256)'](user2.address, 1);
  await ERC721Psi['safeMint(address,uint256)'](user2.address, 1);
  await ERC721A['safeMint(address,uint256)'](user2.address, 1);

  await ERC721Enumerable['benchmarkContractMethods(uint256,address)'](user1TokenId, user1.address);  
  await AddressData['benchmarkContractMethods(uint256,address)'](user1TokenId, user1.address);  
  await ERC721Psi['benchmarkContractMethods(uint256,address)'](user1TokenId, user1.address);  
  await ERC721A['benchmarkContractMethods(uint256,address)'](user1TokenId, user1.address);  
  console.log()
  const user2TokenId = 101;
  await ERC721Enumerable['benchmarkContractMethods(uint256,address)'](user2TokenId, user2.address);  
  await AddressData['benchmarkContractMethods(uint256,address)'](user2TokenId, user2.address);  
  await ERC721Psi['benchmarkContractMethods(uint256,address)'](user2TokenId, user2.address);  
  await ERC721A['benchmarkContractMethods(uint256,address)'](user2TokenId, user2.address);  

  console.log()
  const user1LastTokenId = 100;
  await ERC721Enumerable['benchmarkContractMethods(uint256,address)'](user1LastTokenId, user1.address);  
  await AddressData['benchmarkContractMethods(uint256,address)'](user1LastTokenId, user1.address);  
  await ERC721Psi['benchmarkContractMethods(uint256,address)'](user1LastTokenId, user1.address);  
  await ERC721A['benchmarkContractMethods(uint256,address)'](user1LastTokenId, user1.address);  


  console.log("mint 1000");

  for(let i = 1; i <= 10; i++){
    await ERC721Psi['safeMint(address,uint256)'](user1.address, 1 * perLoop);
    await AddressData['safeMint(address,uint256)'](user1.address, 1 * perLoop);
    await ERC721A['safeMint(address,uint256)'](user1.address, 1 * perLoop);
    await ERC721Enumerable['safeMintBatch(address,uint256)'](user1.address, 1 * perLoop);
    console.log("Minted", perLoop);
  }

  await ERC721Enumerable['safeMintBatch(address,uint256)'](user3.address, 1);
  await AddressData['safeMint(address,uint256)'](user3.address, 1);
  await ERC721Psi['safeMint(address,uint256)'](user3.address, 1);
  await ERC721A['safeMint(address,uint256)'](user3.address, 1);

  console.log()
  const user3LastTokenId = 1102;
  await ERC721Enumerable['benchmarkContractMethods(uint256,address)'](user3LastTokenId, user1.address);  
  await AddressData['benchmarkContractMethods(uint256,address)'](user3LastTokenId, user1.address);  
  await ERC721Psi['benchmarkContractMethods(uint256,address)'](user3LastTokenId, user1.address);  
  await ERC721A['benchmarkContractMethods(uint256,address)'](user3LastTokenId, user1.address);  



}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
