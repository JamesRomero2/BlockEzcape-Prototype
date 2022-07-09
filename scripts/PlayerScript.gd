extends KinematicBody2D

onready var collisionRay := $RayCast2D

var gridSize := 16.00
var canMove := true
var playerInputDirection := Vector2.ZERO

var inventoryResource = load("res://scripts/Inventory.gd")
var inventory = inventoryResource.new()

func _physics_process(_delta):
	if canMove:
		if Input.is_action_just_pressed("ui_up"):
			playerInputDirection = Vector2.UP
			canMove = false
		elif Input.is_action_just_pressed("ui_down"):
			playerInputDirection = Vector2.DOWN
			canMove = false
		if Input.is_action_just_pressed("ui_left"):
			playerInputDirection = Vector2.LEFT
			canMove = false
		elif Input.is_action_just_pressed("ui_right"):
			playerInputDirection = Vector2.RIGHT
			canMove = false
	else:
		playerMove(playerInputDirection)

func playerMove(characterMoveDirection):
	var movePosition = characterMoveDirection * gridSize
	collisionRay.cast_to = movePosition / 2
	collisionRay.force_raycast_update()

	if collisionRay.is_colliding():
		canMove = true
		return
	position += movePosition

