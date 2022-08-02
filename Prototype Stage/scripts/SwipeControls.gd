extends TouchScreenButton

signal swipeDir(swipeDirection)

var onArea := false

func _ready():
	# Set the Rect_Size of the swipe control area
	shape.extents = Vector2(get_parent().get_size())
	self.connect("pressed", self, "_onSelfPressed")
	self.connect("released", self, "_onSelfRelease")

func _input(event):
	if event is InputEventScreenDrag:
		if getSwipeDirection(event.relative, 1) == Vector2.UP:
			emit_signal("swipeDir", Vector2.UP)
		if getSwipeDirection(event.relative, 1) == Vector2.DOWN:
			emit_signal("swipeDir", Vector2.DOWN)
		if getSwipeDirection(event.relative, 1) == Vector2.RIGHT:
			emit_signal("swipeDir", Vector2.RIGHT)
		if getSwipeDirection(event.relative, 1) == Vector2.LEFT:
			emit_signal("swipeDir", Vector2.LEFT)

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

func _onSelfPressed():
	onArea = true

func _onSelfRelease():
	onArea = false
