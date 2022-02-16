const itemManager = artifacts.require("./ItemManager.sol");

contract("itemManager", accounts => {
  it("should be able to add item", async function(){
    const itemMangerInstances = await itemManager.deployed();
    const itemName = "test1";
    const itemPrice = 500;

    const result = await itemMangerInstances.createItem(itemName, itemPrice, {from: accounts[0]});
    console.log(result);
  })
})
