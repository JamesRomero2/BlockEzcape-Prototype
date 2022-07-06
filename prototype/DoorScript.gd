extends Area2D

var doorOpen := false

export (int) var requiredKeys := 3
export (int) var collectedKeys := 0

func _on_Collectibles_keyCollected(item_Name, item_Quantity):
	collectedKeys += 1
	if requiredKeys == collectedKeys:
		doorOpen = true
		print("ALL ORB COLLECTED")
		print("ITEM COLLECTED : ", item_Name, item_Quantity)

func _on_Door_body_entered(body):
	if body.name == "Player":
		if !doorOpen:
			print("DOOR CLOSED, COLLECT ALL ORBS FIRST")
		else:
			print("DOOR OPEN, NEXTLEVEL")


