extends TileMap

const SIZE: int = 16
const WIDTH: int = SIZE * 2
const HEIGHT: int = WIDTH


func _process(_delta):
	generate_map(Vector2i((%Player.position / SIZE) - Vector2(SIZE, SIZE)))


func generate_map(pos):
	for x in range(WIDTH):
		for y in range(HEIGHT):
			if get_cell_source_id(0, Vector2i(x, y) + pos, true) == -1:
				var wall_type = 0
				if randi_range(0, 100) == 0:
					wall_type = Vector2i(randi_range(0, 2), randi_range(0, 2))
				else:
					wall_type = Vector2i(1, 0)

				set_cell(0, Vector2i(x, y) + pos, 1, wall_type)
