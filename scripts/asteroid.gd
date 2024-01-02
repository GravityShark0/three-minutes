extends Area2D

var speed = randi_range(100, 150)
var rotation_speed = randi_range(10, 180)
var direction = Vector2.UP
var damage = randi_range(1, 3)


func _ready():
	$TileMap.set_layer_modulate(
		0, Color(1, float(1) / damage, float(1) / damage, 1)
	)
	$TileMap.set_cell(
		0, Vector2i(0, 0), 0, Vector2i(randi_range(0, 3), randi_range(0, 2))
	)


func _process(delta):
	rotation_degrees += rotation_speed * delta
	position += speed * direction * delta


func _on_body_entered(body: Node2D):
	if body != self:
		if body.has_method("hit"):
			body.hit(1)


func _on_area_entered(area: Area2D):
	if area != self:
		if area.has_method("hit"):
			area.hit(1)


func hit(damage):
	print(damage)
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
