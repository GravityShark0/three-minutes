extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP


func _process(delta):
	position += direction * delta * speed


func _on_laser_timeout_timeout():
	queue_free()


func hit(damage):
	print("damaged")
	queue_free()
