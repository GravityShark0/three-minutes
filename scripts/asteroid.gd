extends Area2D

var speed = randi_range(100, 150)
var rotation_speed = randi_range(10, 180)
var direction = Vector2.UP
var rock_damage = randi_range(1, 3)


func _ready():
	$TileMap.set_layer_modulate(
		0, Color(1, float(1) / rock_damage, float(1) / rock_damage, 1)
	)
	$TileMap.set_cell(
		0, Vector2i(0, 0), 0, Vector2i(randi_range(0, 3), randi_range(0, 2))
	)


func _process(delta):
	rotation_degrees += rotation_speed * delta
	position += speed * direction * delta


func _on_body_entered(body: Node2D):
	if body.has_method("hit"):
		body.hit(rock_damage)


func _on_area_entered(area: Area2D):
	if area.has_method("hit"):
		area.hit(rock_damage)


func hit(damage):
	rock_damage = -damage
	if rock_damage <= 0:
		death()


func death():
	speed = 0
	$CollisionShape2D.queue_free()
	$TileMap.queue_free()
	$AsteroidTimeout.queue_free()
	$Trail.queue_free()
	$Explode.emitting = true


func _on_timer_timeout():
	queue_free()


func _on_explode_finished():
	queue_free()
