extends Area2D

func _onBodyEntered(body):
	if body.name == "Player":
		body.inventory.addItemToInventory("Key", 1)
		queue_free()
