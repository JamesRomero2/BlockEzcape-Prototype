extends TouchScreenButton

# BUGS : SETTING SHAPE WIDTH AND HEIGHT ON RUNTIME RETURNS 0 (ZERO)
# MODIFICATION : ADD LOOK FUNCTIONALITY WHERE THE CHARACTER WILL LOOK INTO THE DIRECTION FIRST BEFORE MOVING TO THE GIVEN DIRECTION

signal swipeDirection(swipeDirection, looking)

var onArea := false

func _ready():
	shape.extents = Vector2(get_parent().rect_min_size.x / 1.6, get_parent().rect_min_size.y / 2)
	self.connect("pressed", self, "_on_self_pressed")
	self.connect("released", self, "_on_self_released")

func _input(event):
	if event is InputEventScreenDrag:
		if getSwipeDirection(event.relative, 1) == Vector2.UP:
			emit_signal("swipeDirection", Vector2.UP)
		if getSwipeDirection(event.relative, 1) == Vector2.DOWN:
			emit_signal("swipeDirection", Vector2.DOWN)
		if getSwipeDirection(event.relative, 1) == Vector2.RIGHT:
			emit_signal("swipeDirection", Vector2.RIGHT)
		if getSwipeDirection(event.relative, 1) == Vector2.LEFT:
			emit_signal("swipeDirection", Vector2.LEFT)

func getSwipeDirection(swipe, swipe_margin):
	var swipeDirection := Vector2.ZERO
	
	if swipe.x >= -swipe_margin and swipe.x <= swipe_margin and swipe.y >= swipe_margin:
		swipeDirection = Vector2.DOWN
	if swipe.x >= -swipe_margin and swipe.x <= swipe_margin and swipe.y <= -swipe_margin:
		swipeDirection = Vector2.UP
	if swipe.y >= -swipe_margin and swipe.y <= swipe_margin and swipe.x >= swipe_margin:
		swipeDirection = Vector2.RIGHT
	if swipe.y >= -swipe_margin and swipe.y <= swipe_margin and swipe.x <= -swipe_margin:
		swipeDirection = Vector2.LEFT

	if onArea == true:
		return swipeDirection

func _on_self_pressed():
	onArea = true

func _on_self_released():
	onArea = false
