extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP
var damage: int = 1


func _process(delta):
	position += direction * delta * speed


func _on_laser_timeout_timeout():
	queue_free()


func _on_body_entered(body: Node2D):
	if body != self:
		if body.has_method("hit"):
			body.hit(damage)


# func _on_area_entered(area: Area2D):
# 	if area != self:
# 		if area.has_method("hit"):
# 			area.hit(damage)


func hit(out_damage):
	damage -= out_damage

	if damage <= 0:
		death()


func death():
	speed = 0
	$CollisionShape2D.queue_free()
	$Sprite2D.queue_free()
	$LaserTimeout.queue_free()
	$Trail.queue_free()
	$Explode.emitting = true


func _on_explode_finished():
	queue_free()
