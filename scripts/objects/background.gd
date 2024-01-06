extends TileMap

## MUST BE SET
## Use any node as an anchor where the background will use the
## anchor.global_position as a CENTER for the background that will be rendered.
@export var background_anchor_point: Node

## When enabled, it will only run the script once.
@export var one_shot: bool = false

## Defines what is the size of the square where it will be rendered.
@export_range(1, 100) var size: int = 16
var width: int = size * 2
var height: int = width

## When enabled, will repleace the standard FastNoiseLite with a randomized pattern instead
## Changes the chance to spawn from the stars_tileset instead of the black tileset
## 1.0 = 1%, 60.0 = 60% chance
@export_range(0.0, 100.0) var starryness: float

var stars = FastNoiseLite.new()


func _ready():
	assert(
		background_anchor_point,
		"Must define background_anchor_point as a node that is exists and is not a child of background"
	)

	stars.seed = randi()
	if one_shot:
		generate_map(background_anchor_point)


func _process(_delta):
	if not one_shot:
		generate_map(background_anchor_point)


## generate a tile based on pos
func generate_map(anchor):
	var pos = local_to_map(anchor.position)

	for x in range(width):
		for y in range(height):
			var x_tile = (pos.x - (float(width) / 2)) + x
			var y_tile = (pos.y - (float(height) / 2)) + y
			# print(x_tile, y_tile)
			# This will run for every cell

			# This if statement checks if the current cell is already set
			# And will run the return if it already does
			if get_cell_source_id(0, Vector2i(x_tile, y_tile), true) != -1:
				continue

			var atlas_id = 0
			var atlas_coords = Vector2(0, 0)
			var alternative_tile = 0

			# Check if starryness is defined
			if starryness:
				# The staryness percent chance is correct

				if randf_range(0, 100) < starryness:
					# Use the second atlas
					atlas_id = 1
					# Randomly select an atlas coordinate from 0, 1, 2 horizontally and vertically
					atlas_coords = Vector2i(
						randi_range(0, 2), randi_range(0, 2)
					)
			else:
				# Use noise instead
				atlas_coords = Vector2i(
					round(
						((stars.get_noise_2d(x_tile, y_tile) * 10) + 20) / 5
					),
					0
				)
				alternative_tile = randi_range(0, 3)
				atlas_id = 2

			# Set cell's tile from atlas_id and atlas_coords
			set_cell(
				0,
				Vector2i(x_tile, y_tile),
				atlas_id,
				atlas_coords,
				alternative_tile
			)
