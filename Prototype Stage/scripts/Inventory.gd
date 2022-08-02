extends Resource
class_name Inventory

signal inventoryChange

export var _items = Array() setget setItems, getItems

func setItems(new_item):
	_items = new_item
	emit_signal("inventoryChange", self)

func getItems():
	return _items

func getOneItemFromInventory(item_index):
	return _items[item_index]

func addItemToInventory(item_name, item_quantity):
	#Avoid Adding Negative Item Number to Inventory
	if item_quantity <= 0:
		print("Player Trying to Add Negative Numbers of Item")
		return

	var item = ItemDatabase.getItemFromDB(item_name)
	if not item:
		print("Item Not in Database. Please Add Item or Check in gameObject/Items folder")
		return
	
	var remainingQuantity = item_quantity
	var maxStackSize = item.maxStackSize if item.stackable else 1

	if item.stackable:
		for i in range(_items.size()):
			if remainingQuantity == 0:
				break
			
			var inventoryItem = _items[i]

			if inventoryItem.item.itemReference.name != item.name:
				continue

			if inventoryItem.item_quantity < maxStackSize:
				var originalQuantity = inventoryItem.item_quantity
				inventoryItem.item_quantity = min(originalQuantity + remainingQuantity, maxStackSize)
				remainingQuantity -= inventoryItem.item_quantity - originalQuantity

	while remainingQuantity > 0:
		var newItem = {
			item_reference = item,
			item_quantity = min(remainingQuantity, maxStackSize)
		}
		_items.append(newItem)
		remainingQuantity -= newItem.item_quantity

	emit_signal("inventoryChange", self)
