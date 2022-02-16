const { assert } = require("console");

const itemManager = artifacts.require("./ItemManager.sol");

contract("itemManager", accounts => {
  it("should be able to add item", async function(){
    const itemMangerInstances = await itemManager.deployed();
    const itemName = "test1";
    const itemPrice = 500;

    const result = await itemMangerInstances.createItem(itemName, itemPrice, {from: accounts[0]});
    assert.equal(result.logs[0].args._itemIdex, 0, "it not the first item");

    const item = await itemMangerInstances.items(0);
    console.log(item);
    assert.equal(item._identifier, itemName, "it not the first item");
  })
})
