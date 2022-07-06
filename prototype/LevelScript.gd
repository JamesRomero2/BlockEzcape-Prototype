extends Node2D

const NUMBERINVENTORYSLOT = 9

signal inventorySignal

export var inventory = {
	0: ["item_0", 1],
	
}

func addItem(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			inventory[item][1] += item_quantity
			return

	for i in range(NUMBERINVENTORYSLOT):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			return


func _on_Collectibles_keyCollected(itemName, itemQuantity):
	addItem(itemName, itemQuantity)
	print(itemName, itemQuantity)
	print(inventory)
	emit_signal("inventorySignal")
