pragma solidity ^0.6.0;

import "./Ownable.sol";
import "./Item.sol";

contract ItemManager is Ownable {
  enum SupplyChainState { Created, Paid, Delivered }
  struct S_item {
    Item _item;
    string _identifier;
    uint _itemPrice;
    ItemManager.SupplyChainState _state;
  }
  mapping(uint => S_item) public items;
  uint itemIdex;

  event SupplyChainStep(uint _itemIdex, uint _step, address _itemAddress);

  function createItem(string memory _identifier, uint _itemPrice) public onlyOwner {
    Item item = new Item(this, _itemPrice, itemIdex);
    items[itemIdex]._item = item;
    items[itemIdex]._identifier = _identifier;
    items[itemIdex]._itemPrice = _itemPrice;
    items[itemIdex]._state = SupplyChainState.Created;
    emit SupplyChainStep(itemIdex, uint(items[itemIdex]._state), address(item));
    itemIdex++;
  }

  function triggerPayment(uint _itemIndex) public payable {
    require(items[_itemIndex]._itemPrice == msg.value, "Only full payment accepted");
    require(items[_itemIndex]._state == SupplyChainState.Created, "item is not found in tha chain");
    emit SupplyChainStep(_itemIndex, uint(items[_itemIndex]._state), address(items[_itemIndex]._item));

    items[_itemIndex]._state = SupplyChainState.Paid;
  }

  function triggerDelivery(uint _itemIndex) public onlyOwner {
    require(items[_itemIndex]._state == SupplyChainState.Paid, "item has not been paid in tha chain");
    items[_itemIndex]._state = SupplyChainState.Delivered;

    emit SupplyChainStep(_itemIndex, uint(items[_itemIndex]._state), address(items[_itemIndex]._item));

  }
}
