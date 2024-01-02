extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP


func _process(delta):
	position += direction * delta * speed


func _on_body_entered(body: Node2D):
	if body != self:
		body.free()
		free()
