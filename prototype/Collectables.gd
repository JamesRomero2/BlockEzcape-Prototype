extends Area2D

signal keyCollected

func _on_Collectibles_body_entered(body):
	if body.name == "Player":
		emit_signal("keyCollected")
		queue_free()
