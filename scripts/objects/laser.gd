extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP
var laser_damage: int = 1


func _process(delta):
	position += direction * delta * speed


func _on_laser_timeout_timeout():
	queue_free()


func _on_body_entered(body: Node2D):
	if not "player_health" in body:
		if body.has_method("hit"):
			body.hit(laser_damage)


func _on_area_entered(area: Area2D):
	if area.has_method("hit"):
		area.hit(laser_damage)


func hit(damage):
	if laser_damage - damage <= 0:
		return death()

	laser_damage -= damage

func death():
	speed = 0
	$CollisionShape2D.queue_free()
	$Sprite2D.queue_free()
	$LaserTimeout.queue_free()
	$Trail.queue_free()
	$Explode.emitting = true


func _on_explode_finished():
	queue_free()
