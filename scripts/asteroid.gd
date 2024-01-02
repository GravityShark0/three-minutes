extends Area2D

var speed = randi_range(200, 500)
var direction = Vector2.UP


func _ready():
	$TileMap.set_cell(
		0, Vector2i(0, 0), 0, Vector2i(randi_range(0, 1), randi_range(0, 2))
	)
	#
	# match randi_range(0, 3):
	# 	0:
	# 		# Left
	# 		var spawnpoint = Vector2(-425, randi_range(-325, 325))
	# 		position = (%Player.spawnpoint + spawnpoint)
	# 		direction = spawnpoint.normalized()
	#
	# 	1:
	# 		# Right
	# 		var spawnpoint = Vector2(425, randi_range(-325, 325))
	# 		position = (%Player.spawnpoint + spawnpoint)
	# 		direction = spawnpoint.normalized()
	#
	# 	2:
	# 		# Top
	# 		var spawnpoint = Vector2(-425, randi_range(-325, 325))
	# 		position = (%Player.spawnpoint + spawnpoint)
	# 		direction = spawnpoint.normalized()
	#
	# 	3:
	# 		# Bottom
	# 		var spawnpoint = Vector2(randi_range(-425, 425), -325)
	# 		position = (%Player.spawnpoint + spawnpoint)
	# 		direction = spawnpoint.normalized()


func _process(delta):
	position += speed * direction * delta


func _on_body_entered(body: Node2D):
	if body != self:
		body.free()
		free()
