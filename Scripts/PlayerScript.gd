extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer
onready var verticalCollision = $VerticalCollision
onready var horizontalCollision = $HorizontalCollision

export(int) var speed := 16

var lookingDirection := Vector2.UP
var canMove := true
var velocity := Vector2.ZERO

func _physics_process(_delta):
	if velocity != Vector2.ZERO:
		canMove = false

	if velocity.x != 0:
		horizontalCollision.disabled = false
		verticalCollision.disabled = true
		if velocity.x > 0:
			animationPlayer.play("Look_Right")
		elif velocity.x < 0:
			animationPlayer.play("Look_Left")
	elif velocity.y != 0:
		horizontalCollision.disabled = true
		verticalCollision.disabled = false
		if velocity.y < 0:
			animationPlayer.play("Look_Forward")
		elif velocity.y > 0:
			animationPlayer.play("Look_Backward")

	var collision = move_and_collide(velocity * speed)

	if collision != null:
		canMove = true

func _on_TouchScreenButton_swipeDirection(swipeDirection:Vector2):
	if canMove:
		velocity = swipeDirection












# OPTIMIZATION SUGGESTION : STATES
# func _idle_to_last_direction(direction: Vector2):
#     # When the character is not moving.
#     # Transition to _look_to_direction, when the player hold and drag
#     # the screen.
#     animationPlayer.play("Idle_Forward");

# func _look_to_direction(direction: Vector2):
#     # When the player hold of the screen the 
#     # character will look into the corresponding direction.
#     # Transition to _move_to_direction, when the player let go
#     # holding the screen and starts to move to the direction
#     pass

# func _move_to_direction(direction: Vector2):
#     # When the player let go of touching the screen,
#     # the character will move to the designated direction.
#     # Transition to _idle_to_last_direction, when the character
#     # stops moving.
#     pass



