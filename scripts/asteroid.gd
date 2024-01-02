extends CharacterBody2D

var speed = 400
var direction = Vector2.UP


func _process(_delta):
	velocity = speed * direction
	move_and_slide()
