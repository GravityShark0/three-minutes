extends TileMap

const SIZE: int = 16
const WIDTH: int = SIZE * 2
const HEIGHT: int = WIDTH


func _process(_delta):
	generate_map(Vector2i((%Player.position / SIZE) - Vector2(SIZE, SIZE)))
	# erase_cell(0, Vector2i(0, 0))
	# set_pattern()


func generate_map(pos):
	for x in range(WIDTH):
		for y in range(HEIGHT):
			set_cell(0, Vector2i(x, y) + pos, 0, Vector2i(0, 0))
