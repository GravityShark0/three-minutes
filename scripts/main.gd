extends Node2D

@export var difficulty: float = 1
@export var difficulty_increase: float = 0.001
# const OUTWARD_LIMIT: int = Vector2(450, 350)

var laser_scene: PackedScene = preload("res://scenes/objects/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/objects/grenade.tscn")
var asteroid_scene: PackedScene = preload("res://scenes/objects/asteroid.tscn")

func _on_player_primary_fire(node, pos, direction):
	if node is Player:
		var laser = laser_scene.instantiate() as Area2D
		$Projectiles.add_child(laser)
		laser.global_position = pos
		laser.rotation = direction.angle()
		laser.direction = direction
	else:
		print('ass')

func _ready():
	var current_scene = get_tree().get_current_scene()

	# if current_scene.get_name() == "Main":
		# Sound.stop()


func _process(_delta):
	# Sound.stop()
	difficulty += difficulty_increase
	var random_check = randi_range(0, int(50 / difficulty))
	# var random_check = 0
	if random_check == 0:
		var asteroid = asteroid_scene.instantiate() as Area2D
		$Projectiles.add_child(asteroid)

		match randi_range(0, 3):
			0:
				# Left
				var spawnpoint = Vector2(-425, randi_range(-325, 325))
				asteroid.position = (%Player.position + spawnpoint)
				# asteroid.direction = spawnpoint.normalized()
				asteroid.direction = (
					Vector2.RIGHT + Vector2(0, randf_range(-1, 1))
				)
			1:
				# Right
				var spawnpoint = Vector2(425, randi_range(-325, 325))
				asteroid.position = (%Player.position + spawnpoint)
				asteroid.direction = (
					Vector2.LEFT + Vector2(0, randf_range(-1, 1))
				)

			2:
				# Top
				var spawnpoint = Vector2(-425, randi_range(-325, 325))
				asteroid.position = (%Player.position + spawnpoint)
				asteroid.direction = (
					Vector2.DOWN + Vector2(randf_range(-1, 1), 0)
				)

			3:
				# Bottom
				var spawnpoint = Vector2(randi_range(-425, 425), -325)
				asteroid.position = (%Player.position + spawnpoint)
				asteroid.direction = (
					Vector2.UP + Vector2(randf_range(-1, 1), 0)
				)


func _on_player_after_death():
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")

func _on_upgrade_button_pressed(example):
	print(example)
