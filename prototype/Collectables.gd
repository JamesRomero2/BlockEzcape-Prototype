extends Area2D

signal keyCollected(itemName, itemQuantity)
export var itemName := ""
export var itemQuantity = 0

func _on_Collectibles_body_entered(body):
	if body.name == "Player":
		emit_signal("keyCollected", itemName, itemQuantity)
		queue_free()
