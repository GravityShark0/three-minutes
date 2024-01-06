extends Camera2D

## Sets the radius of the square in pixels for the radius of when should the cursor go back go steady on the player
@export var deadzone: int = 60

## Sets how much will the cursor lean off to the sides
@export var offset_multiplier: int = 240
var viewport = get_viewport()

func _process(_delta):
	var middle = (get_viewport_rect().size / 2)
	var deadzone_vector = Vector2(deadzone, deadzone)
	var minimum = middle - deadzone_vector
	var maximum = middle + deadzone_vector
	var mouse_pos = (get_viewport().get_mouse_position())
	
	if not(minimum.x < mouse_pos.x and mouse_pos.x < maximum.x and minimum.y < mouse_pos.y and mouse_pos.y < maximum.y):
		drag_horizontal_offset = (mouse_pos.x - middle.x) / offset_multiplier
		drag_vertical_offset = (mouse_pos.y - middle.y) / offset_multiplier
	else:
		drag_horizontal_offset = 0
		drag_vertical_offset = 0
