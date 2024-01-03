extends TileMap

## Use any node as an anchor where the background will use the
## anchor.global_position as a CENTER for the background that will be rendered.
@export var background_anchor_point: Node

## When enabled, it will only run the script once.
@export var one_shot: bool = false

## Defines what is the size of the square where it will be rendered.
@export_range(1, 100) var size: int = 16
var width: int = size * 2
var height: int = width

## Changes the chance to spawn from the stars_tileset instead of the black tileset
## 1.0 = 1%, 60.0 = 60% chance
@export_range(0.0, 100.0) var starryness: float = 1.0


func _ready():
	if one_shot:
		generate_map(
			Vector2i(
				(
					(background_anchor_point.position / size)
					- Vector2(size, size)
				)
			)
		)


func _process(_delta):
	if not one_shot:
		generate_map(
			Vector2i(
				(
					(background_anchor_point.position / size)
					- Vector2(size, size)
				)
			)
		)


## generate a tile based on pos
func generate_map(pos):
	for x in range(width):
		for y in range(height):
			# This will run for every cell

			# This if statement checks if the current cell is already set
			# And will run the return if it already does
			if get_cell_source_id(0, Vector2i(x, y) + pos, false) != -1:
				continue

			# Default atlas_id = 0
			# Default atlas_coords = 0, 0
			var atlas_id = 0
			var atlas_coords = Vector2i(0, 0)

			# The staryness percent chance is correct
			if randf_range(0, 100) < starryness:
				# Use the second atlas
				atlas_id = 1
				# Randomly select an atlas coordinate from 0, 1, 2 horizontally and vertically
				atlas_coords = Vector2i(randi_range(0, 2), randi_range(0, 2))

			# Set cell's tile from atlas_id and atlas_coords
			set_cell(0, Vector2i(x, y) + pos, atlas_id, atlas_coords)
