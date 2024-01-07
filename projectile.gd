extends Area2D
class_name Projectile

@export var speed: int
var damage := Damage.new()
@export var direction: Vector2
@export var rotation_speed: int
@export var parent: Ship
@export var explode_particle: GPUParticles2D

func _ready():
	pass


func _process(delta):
	
	if damage.damage > 0:
		rotation_degrees += rotation_speed * delta
		position += speed * direction * delta

func hit(taken_damage):
	if (damage.damage - taken_damage.damage) <= 0:
		return death()

	damage.damage -= taken_damage.damage
	direction += damage.knockback_direction * damage.knockback_strength
	hit_action(taken_damage.damage)

## hit_action is a custom action after a damage has been taken
func hit_action(taken_damage):
	
	print("ive been hit for ", taken_damage.damage)

func death():
	speed = 0
	for child in get_children():
		if child != explode_particle:
			child.queue_free()
	explode_particle.emitting = true
