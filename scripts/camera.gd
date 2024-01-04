extends Camera2D

@export var deadzone: int = 60
var viewport = get_viewport()

func _process(_delta):
	var deaderzone = deadzone
	
	# var mouse_pos = (get_viewport().get_mouse_position() - (get_viewport_rect().size / 2))
	var middle = (get_viewport_rect().size / 2)
	var minimum = middle - Vector2(deaderzone, deaderzone)
	var maximum = middle + Vector2(deaderzone, deaderzone)
	var mouse_pos = (get_viewport().get_mouse_position())
	
	# print(mouse_pos, " ", middle, " ", min, " ", max)


	if not(minimum.x < mouse_pos.x and mouse_pos.x < maximum.x and minimum.y < mouse_pos.y and mouse_pos.y < maximum.y):
		print((mouse_pos - middle) / 60)
		drag_horizontal_offset = (mouse_pos.x - middle.x) / 120
		drag_vertical_offset = (mouse_pos.y - middle.y) / 120
		print(drag_horizontal_offset, " ", drag_vertical_offset)
	else:
		drag_horizontal_offset = 0
		drag_vertical_offset = 0
