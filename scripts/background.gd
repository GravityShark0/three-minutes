extends TileMap

## Use any node as an anchor where the background will use the anchor.position as a CENTER for the background that will be rendered.
@export var background_anchor_point: Node

## When enabled, it will only run the script once.
@export var one_shot: bool = false

## Defines what is the size of the square where it will be rendered.
@export_range(1, 100) var SIZE: int = 16
var WIDTH: int = SIZE * 2
var HEIGHT: int = WIDTH

## Changes the chance to spawn from the stars_tileset instead of the black tileset
## 1.0 = 1%, 60.0 = 60% chance
@export_range(0.0, 100.0) var starryness: float = 1

func _ready():
	if one_shot:
		generate_map(Vector2i((background_anchor_point.position / SIZE) - Vector2(SIZE, SIZE)))


func _process(_delta):
	if not one_shot:
		generate_map(Vector2i((background_anchor_point.position / SIZE) - Vector2(SIZE, SIZE)))



func generate_map(pos):
	for x in range(WIDTH):
		for y in range(HEIGHT):
			if get_cell_source_id(0, Vector2i(x, y) + pos, true) == -1:
				var wall_type = 0
				if randf_range(0, 100) < starryness:
					wall_type = Vector2i(randi_range(0, 2), randi_range(0, 2))
				else:
					wall_type = Vector2i(1, 0)

				set_cell(0, Vector2i(x, y) + pos, 1, wall_type)
