extends Area2D

var speed = randi_range(100, 150)
var rotation_speed = randi_range(10, 180)
var direction = Vector2.UP
var rock_damage = randi_range(1, 3)


func _ready():
	$Sprite2D.region_rect.position = Vector2(randi_range(0, 3) * 16, randi_range(0, 2) * 16)

	$Sprite2D.modulate = Color(1, float(1) / rock_damage, float(1) / rock_damage, 1)
	


func _process(delta):
	if rock_damage > 0:
		rotation_degrees += rotation_speed * delta
		position += speed * direction * delta


func _on_body_entered(body: Node2D):
	if body.has_method("hit"):
		body.hit(rock_damage)
	elif body is Ship:
		body.hit(rock_damage)
		hit(body.player_health)


func _on_area_entered(area: Area2D):
	if area.has_method("hit"):
		area.hit(rock_damage)


func hit(damage):
	if rock_damage - damage <= 0:
		return death()

	rock_damage -= damage
		
	$Sprite2D.modulate = Color(1, float(1) / rock_damage, float(1) / rock_damage, 1)
	



func death():
	speed = 0
	$CollisionShape2D.queue_free()
	$Sprite2D.queue_free()
	$AsteroidTimeout.queue_free()
	$Trail.queue_free()
	$Explode.emitting = true


func _on_timer_timeout():
	queue_free()


func _on_explode_finished():
	queue_free()
