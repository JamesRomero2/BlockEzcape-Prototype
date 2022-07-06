extends Panel

var itemClass = preload("res://prototype/Item.tscn")
var item = null

func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null
	
func putIntoSlot(newItem):
	item = newItem
	item.position = Vector2(3, 3)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)
	
func initializeItem(itemName, itemQuantity):
	if item == null:
		item = itemClass.instance()
		add_child(item)
		item.set_item(itemName, itemQuantity)
	else:
		item.set_item(itemName, itemQuantity)
