extends KinematicBody2D

onready var verticalCollision = $Vectical
onready var horizontalCollision = $Horizontal

var inventoryResource = load("res://scripts/Inventory.gd")
var inventory = inventoryResource.new()

export(int) var speed := 0
export(bool) var canMove := true
var velocity := Vector2.ZERO

func _physics_process(_delta):
	if velocity != Vector2.ZERO:
		canMove = false

	if velocity.x != 0:
		horizontalCollision.disabled = false
		verticalCollision.disabled = true
	elif velocity.y != 0:
		horizontalCollision.disabled = true
		verticalCollision.disabled = false
	
	var collision = move_and_collide(velocity * speed)

	if collision != null:
		canMove = true


func _on_TouchScreenButton_swipeDir(swipeDirection):
	if canMove:
		velocity = swipeDirection
